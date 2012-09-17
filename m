From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Sep 2012 09:51:38 +0200
Subject: [PATCH 00/34] i.MX multi-platform support
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120917075138.GN6180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Sep 17, 2012 at 01:34:29PM +0800, Shawn Guo wrote:
> The series enables multi-platform support for imx.  Since the required
> frameworks (clk, pwm) and spare_irq have already been adopted on imx,
> the series is all about cleaning up mach/* headers.  Along with the
> changes, arch/arm/plat-mxc gets merged into arch/arm/mach-imx.
> 
> It's based on a bunch of branches (works from others), Rob's initial
> multi-platform series, Arnd's platform-data and smp_ops (Marc's) and
> imx 3.7 material (Sascha and myself).
> 
> It's available on branch below.
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/multi-platform
> 
> It's been tested on imx5 and imx6, and only compile-tested on imx2 and
> imx3, so testing on imx2/3 are appreciated.

Great work! This really pushes the i.MX architecture one step closer to
a clean code base.

I gave it a test on i.MX1, i.MX27, i.MX31 and i.MX35. All run fine, but
the last patch breaks the imx_v4_v5_defconfig: Somehow it now defaults
to ARMv7 based machines. I haven't looked into it, just reenabled
ARMv4/ARMv5 and the boards again -> works. The config should be updated
with the last patch.

I'm fine with the changes to mx2-camera, but Javier should give his ok
to it, he has worked on it quite a lot recently.

One other issue related to imx-dma, see comment to that patch.

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
