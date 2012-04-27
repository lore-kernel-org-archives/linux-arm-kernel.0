From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 10:31:42 +0200
Subject: [PATCH v3 4/4] mmc: sdhci-imx-esdhc: convert to use pinctrl
 subsystem
In-Reply-To: <20120427082930.GC826@shlinux2.ap.freescale.net>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-4-git-send-email-b29396@freescale.com>
 <20120427073504.GS17184@pengutronix.de>
 <20120427082930.GC826@shlinux2.ap.freescale.net>
Message-ID: <20120427083142.GY17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 04:29:31PM +0800, Dong Aisheng wrote:
> mach-imx27ipcam.c          mach-mx31ads.c             mach-mx51_babbage.o        mach-pca100.c
> mach-imx27lite.c           mach-mx31ads.o             mach-mx51_efikamx.c        mach-pcm037.c
> 
> Some of them i'm not familiar and i don't know whether they may use pinctrl
> so i just patched the affected ones.
> 
> One lazy method may be just patch all board files without pinctrl support
> and it will not cause any error.
> 
> What's your suggestion?
> 
> > pinctrl. Let's add the provide_dummies call to the SoCs instead which
> > do not have pinctrl yet.
> > 
> You meant add provide_dummies call in imx*_soc_init call?
> We could do it but there might be a case that some boards are converted
> to use pinctrl while others still not but they're based on the same soc.
> For examples, 4 mx53 boards and we may not be able to convert them all at
> the same time.

My point is that none of the mx5 boards have pinctrl since there is no
SoC driver for it.
For DT based boards pinctrl should be mandatory once the SoC has pinctrl
support. All non DT boards probably won't get pinctrl anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
