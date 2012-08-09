From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Aug 2012 08:32:10 +0200
Subject: imx6q restart is broken
In-Reply-To: <20120809044131.GF14718@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809044131.GF14718@S2101-09.ap.freescale.net>
Message-ID: <20120809063209.GM1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 12:41:38PM +0800, Shawn Guo wrote:
> On Thu, Aug 09, 2012 at 11:18:47AM +0800, Hui Wang wrote:
> > 
> > - i think we should split imx_v6_v7_defconfig into v6_only and
> > v7_only, since when we use imx_v6_v7_defconfig, we will introduce
> > "-D__LINUX_ARM_ARCH__=6" unconditionally, this macro is OK for V6
> > platforms (imx3), but it is not good for V7 platforms (imx5, imx6).
> > lets grep "__LINUX_ARM_ARCH__" occurrence under the arch/arm, all
> > (#if __LINUX_ARM_ARCH__ == 6) and (#if __LINUX_ARM_ARCH__ >= 7)
> > occurrence will affect V7 platforms.
> 
> I just copied a few more people.  Let's hear their comments.

As a last resort we could split the defconfigs, but before we should
try to find a solution for this problem.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
