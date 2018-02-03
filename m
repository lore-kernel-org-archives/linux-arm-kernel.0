From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 2 Feb 2018 22:03:07 -0200
Subject: [PATCH v3 3/3] ARM: dts: imx: Add memory node unit name
In-Reply-To: <1516800134-5018-3-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
 <1516800134-5018-3-git-send-email-marcofrk@gmail.com>
Message-ID: <CAOMZO5AfEon8mGLZyYQav_TjZ5h7KMVvE8ks4Ruw4xyj48wofA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 11:22 AM, Marco Franchi <marcofrk@gmail.com> wrote:
> Fix the following warnings from dtc by adding the unit name to memory
> nodes:
>
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>
> Converted using the following command:
>
> perl -p0777i -e 's/memory \{\n\t\treg = \<0x+([0-9a-f])/memory\@$1$\0000000 \{\n\t\treg = <0x$1/m' `find ./arch/arm/boot/dts -name "imx*"`
>
> The files below were manually fixed:
> -imx1-ads.dts
> -imx1-apf9328.dts
> -imx6q-pistachio.dts
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
