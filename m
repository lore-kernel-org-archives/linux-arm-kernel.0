From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Dec 2011 15:40:49 +0000
Subject: [PATCH V2 1/2] pinctrl: enable pinmux for pxa series
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1751860B1F@HQMAIL01.nvidia.com>
References: <1323769253-22580-1-git-send-email-haojian.zhuang@marvell.com>
 <1323769253-22580-2-git-send-email-haojian.zhuang@marvell.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1751860B1F@HQMAIL01.nvidia.com>
Message-ID: <201112141540.49243.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 December 2011, Stephen Warren wrote:
> Haojian Zhuang wrote at Tuesday, December 13, 2011 2:41 AM:
> 
> > diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> 
> > +obj-$(CONFIG_PINMUX_PXA168)	+= pinmux-pxa168.o pinctrl-pxa3xx.o
> > +obj-$(CONFIG_PINMUX_PXA300)	+= pinmux-pxa300.o pinctrl-pxa3xx.o
> > +obj-$(CONFIG_PINMUX_PXA910)	+= pinmux-pxa910.o pinctrl-pxa3xx.o
> 
> That structure will cause problems if multiple of those Kconfig options
> are enabled at once, as in a multi-SoC kernel. Instead, shouldn't this be:
> 
> obj-$(CONFIG_PINCTRL_PXA3XX)	+= pinctrl-pxa3xx.o
> obj-$(CONFIG_PINMUX_PXA168)	+= pinmux-pxa168.o
> obj-$(CONFIG_PINMUX_PXA300)	+= pinmux-pxa300.o
> obj-$(CONFIG_PINMUX_PXA910)	+= pinmux-pxa910.o

I'm pretty sure the first version is ok too, as long as none of the
options can be built as modules.  Your version seems to be more common though.

	Arnd
