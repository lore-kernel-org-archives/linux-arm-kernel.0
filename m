From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 31 Aug 2011 22:05:28 +0800
Subject: i.MX multi SoC patches
In-Reply-To: <CAODfWeFnsQZBsBXpJLVknzvqcythZjDMyfe8sb9Pdw_uK-iB2g@mail.gmail.com>
References: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
	<CAODfWeFnsQZBsBXpJLVknzvqcythZjDMyfe8sb9Pdw_uK-iB2g@mail.gmail.com>
Message-ID: <20110831140527.GA3723@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 02:02:58PM +0100, Hector Oron wrote:
> Hello,
> 
> 
> 2011/8/24 Sascha Hauer <s.hauer@pengutronix.de>:
> > This is hopefully the last iteration of the patches for compiling
> > all ARMv4/v5 based i.MXs together. CONFIG_ARM_PATCH_PHYS_VIRT
> > lost its experimental status and we can still build uImages
> > even with CONFIG_AUTO_ZRELADDR enabled. This series selects
> > these options and makes a multi SoC image the default.
> > Also, we can now build all i.MX5 SoCs into a single image.
> > This series also updates the defconfigs.
> 
> On a mx53 loco board I have rebased Richard's patchset for SATA and
> got it running, but I see this on mapping on iomem, board is more or
> less working but I was unsure if this is something significant or just
> some ugly cosmetic names for mx53 (i.e. imx21-uart.0, imx31-gpio, ..)
> 
This is expected.  The platform_device_id had been used to kill
cpu_is_mxXX() stuff from drivers.  And we decided to use soc prefix
to define IP block version in platform_device_id table, because
hardware does not define revisions, and soc is stable enough to
identify specific IP block version.

-- 
Regards,
Shawn
