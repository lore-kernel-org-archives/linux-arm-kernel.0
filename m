From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Jan 2013 23:41:46 -0800
Subject: [GIT PULL] i.MX SoC updates for v3.9
In-Reply-To: <20130125101510.GK1906@pengutronix.de>
References: <20130125101510.GK1906@pengutronix.de>
Message-ID: <20130128074146.GJ25723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I know i.MX usually doesn't have a whole lot of patches for each release,
so requiring you to split up in 3-4 branches due to category might not
make much sense. Keep it in mind if you do have higher volume for some
merge window though.

Some comments below, mostly to keep in mind for future code reviews.

I've pulled this in as imx/soc, part of next/soc.


On Fri, Jan 25, 2013 at 11:15:10AM +0100, Sascha Hauer wrote:
> Hi Arnd, Olof,
> 
> Please pull the following (mostly clock relates) updates for v3.9.
> 
> Sascha
> 
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-soc
> 
> for you to fetch changes up to 3ea8098572280d16163a429e0f8dfd90492a5934:
> 
>   ARM: clk-imx35: Fix build warnings with W=1 (2013-01-25 11:12:38 +0100)
> 
> ----------------------------------------------------------------
> ARM i.MX SoC updates for next
> 
> Mostly clock related updates, most notably the conversion of
> i.MX31 to a DT based lookup.
> 
> ----------------------------------------------------------------
> Fabio Estevam (4):
>       ARM: Let CONFIG_MACH_IMX31_DT be built by default

Patch subject here isn't quite right. This is really more like "ARM:
imx: add CONFIG_MACH_IMX31_DT to defconfig". Missing platform prefix too.

>       ARM: clk-imx31: Add dummy clock
>       ARM: mx31: Replace clk_register_clkdev with clock DT lookup

This could maybe have been split up in a few changes -- adding infrastructure
/ code in one, dts/dtsi updates in a second and a third with auxdata removal.
Either way, same end result so not a big deal.

I didn't see the patch posted to devicetree-discuss, but since the binding is
pretty standard I won't hold back due to it.



-Olof
