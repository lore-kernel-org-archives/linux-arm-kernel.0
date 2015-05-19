From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 13:04:22 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add Atmel SAMA5 family
In-Reply-To: <555AFF3F.10400@atmel.com>
References: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
 <555AFF3F.10400@atmel.com>
Message-ID: <9986808.t62JLgg5NJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 11:15:43 Nicolas Ferre wrote:
> Le 03/04/2015 11:01, Alexandre Belloni a ?crit :
> > Add the Atmel sama5d3 and sama5d4 and their peripherals to multi_v7_defconfig.
> > 
> > Note that the console will be ttyAT0 instead of the usual ttyS0.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> It seems good to me: thanks Alexandre.
> 
> Arnd, Olof, Kevin: do you have a comment about this addition?

We're trying to move to a more modular build of multi_v7_defconfig.
Please make all drivers that are not required for booting '=m',
and ensure that they have a MODULE_DEVICE_TABLE entry that allows
autoloading.

Most of the symbols are already marked =m here, but there are a
few that I'm wondering about:

> If it's okay on your side, I may have to rebase it on top of whichever
> branch you want, just to avoid conflicts:
> - your most recent arm-soc/next/defconfig branch
> - or the v4.1-rc3 tag on which the branch is made from?

-rc3 is fine, we can easily handle the conflicts when merging in your
patch.

> > @@ -250,15 +261,18 @@ CONFIG_SERIAL_FSL_LPUART=y
> >  CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> >  CONFIG_SERIAL_ST_ASC=y
> >  CONFIG_SERIAL_ST_ASC_CONSOLE=y
> > +CONFIG_HW_RANDOM=y
> >  CONFIG_I2C_CHARDEV=y
> >  CONFIG_I2C_DAVINCI=y
> >  CONFIG_I2C_MUX=y

seems non-essential.

> > @@ -502,6 +522,8 @@ CONFIG_RTC_DRV_MV=y
> >  CONFIG_RTC_DRV_TEGRA=y
> >  CONFIG_DMADEVICES=y
> >  CONFIG_DW_DMAC=y
> > +CONFIG_AT_HDMAC=y
> > +CONFIG_AT_XDMAC=y
> >  CONFIG_MV_XOR=y
> >  CONFIG_TEGRA20_APB_DMA=y
> >  CONFIG_SH_DMAE=y

What are these required for? I assume you need them for MMC? If so, that's
fine.

	Arnd
