From: aneesh@ti.com (Aneesh V)
Date: Tue, 20 Dec 2011 12:49:29 +0530
Subject: [RFC v2 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram
 controller
In-Reply-To: <CAOesGMidr_orQ60wWrDkSPXZziZ6wuThTixmQj-idkkDjrMG0A@mail.gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>	<1324303533-17458-3-git-send-email-aneesh@ti.com>
 <CAOesGMidr_orQ60wWrDkSPXZziZ6wuThTixmQj-idkkDjrMG0A@mail.gmail.com>
Message-ID: <4EF03701.9090809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 December 2011 10:29 PM, Olof Johansson wrote:
> Oh wait, when I saw 3/3 I realized the following too:
>
> On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V<aneesh@ti.com>  wrote:
>
>> +- phy-type     : string indicating the phy type. Should be one of the
>> +  following:
>> +
>> +  "phy-type-omap4"  : PHY used in OMAP4 family of SoCs
>> +
>> +  "phy-type-dm81xx" : PHY used in DM81XX family of SoCs
>
> No, again please don't define new string properties when a simple
> binary property will do just fine. Just use "phy-type-omap4" or
> "phy-type-dm81xx" as an empty property to indicate what phy is used.
> Or encode as an integer and list the valid values here.

Ok. I just got carried away by readability. Somebody told me that
something like #define will come to device-tree soon. Probably, I can
use that then.

Is binary property suitable in situations like this where "one and only
one" phy-type should be specified by the user?

>
> Every time you add a string to the device tree, the data structure
> grows, not to mention the fact that it adds a lot of string
> comparisons during setup. Please keep that in mind when defining
> bindings.

Understand.

Thanks,
Aneesh
