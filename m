From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Feb 2013 12:02:14 +0800
Subject: [PATCH] ASoC: fsl: fix allyesconfig build for imx-pcm
In-Reply-To: <201302051642.25361.arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <20130122063331.GA1766@opensource.wolfsonmicro.com>
 <201302051621.12320.arnd@arndb.de>
 <201302051642.25361.arnd@arndb.de>
Message-ID: <20130206040212.GA18613@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 04:42:25PM +0000, Arnd Bergmann wrote:
> Patch 25b8d314 "ASoC: fsl: fix multiple definition of init_module changed
> the Makefile for imx-pcm.ko to build two modules that both contain the
> imx-pcm.c file, which nicely solves the problem of building both versions
> of the driver as modules, but it causes two new problems:
> 
It's my fault, Arnd.  The patch 25b8d314 is a crap.  Instead of making
the Kconfig even complexer, I chose to revert the patch and do a little
surgery on the code to make it match the Kconfig rational.  The fix[1]
should be on the way to mainline now.

I'm sorry for messing thing up during -rc time.

Shawn

[1] http://thread.gmane.org/gmane.linux.alsa.devel/105018
