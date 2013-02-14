From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 14 Feb 2013 09:45:24 +0100 (CET)
Subject: [PATCH 3/3] ARM: mach-shmobile: kzm9g: do not enable
 REGULATOR_DUMMY in defconfig
In-Reply-To: <20130214083621.GA8236@verge.net.au>
References: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
 <1360761103-17357-4-git-send-email-horms+renesas@verge.net.au>
 <20130214083621.GA8236@verge.net.au>
Message-ID: <Pine.LNX.4.64.1302140942250.29693@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Feb 2013, Simon Horman wrote:

> On Wed, Feb 13, 2013 at 10:11:43PM +0900, Simon Horman wrote:
> > Don't enable REGULATOR_DUMMY, it is only intended for development / testing.
> > There doesn't seem to be any value in setting it here and doing
> > so was an error on my part.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/configs/kzm9g_defconfig |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
> > index 670c3b6..6751c02 100644
> > --- a/arch/arm/configs/kzm9g_defconfig
> > +++ b/arch/arm/configs/kzm9g_defconfig
> > @@ -86,7 +86,6 @@ CONFIG_I2C_SH_MOBILE=y
> >  CONFIG_GPIO_PCF857X=y
> >  # CONFIG_HWMON is not set
> >  CONFIG_REGULATOR=y
> > -CONFIG_REGULATOR_DUMMY=y
> >  CONFIG_FB=y
> >  CONFIG_FB_SH_MOBILE_LCDC=y
> >  CONFIG_FRAMEBUFFER_CONSOLE=y
> 
> This patch seems to break NIC initialisation.
> 
> smsc911x: Driver version 2008-10-21
> smsc911x smsc911x.0: Failed to get supply 'vdd33a': -517
> smsc911x smsc911x.0 (unregistered net_device): couldn't get regulators -517
> platform smsc911x.0: Driver smsc911x requests probe deferral

Right, you need a fixed regulator similar to how I adde it here

http://www.spinics.net/lists/linux-sh/msg15713.html

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
