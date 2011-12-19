From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 08:59:18 -0800
Subject: [RFC v2 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram
 controller
In-Reply-To: <1324303533-17458-3-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
 <1324303533-17458-3-git-send-email-aneesh@ti.com>
Message-ID: <CAOesGMidr_orQ60wWrDkSPXZziZ6wuThTixmQj-idkkDjrMG0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh wait, when I saw 3/3 I realized the following too:

On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V <aneesh@ti.com> wrote:

> +- phy-type ? ? : string indicating the phy type. Should be one of the
> + ?following:
> +
> + ?"phy-type-omap4" ?: PHY used in OMAP4 family of SoCs
> +
> + ?"phy-type-dm81xx" : PHY used in DM81XX family of SoCs

No, again please don't define new string properties when a simple
binary property will do just fine. Just use "phy-type-omap4" or
"phy-type-dm81xx" as an empty property to indicate what phy is used.
Or encode as an integer and list the valid values here.

Every time you add a string to the device tree, the data structure
grows, not to mention the fact that it adds a lot of string
comparisons during setup. Please keep that in mind when defining
bindings.



-Olof
