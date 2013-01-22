From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Jan 2013 11:50:30 +0800
Subject: [PATCH 05/15] ASoC: fsl: fiq and dma cannot both be modules
In-Reply-To: <1358788568-11137-6-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-6-git-send-email-arnd@arndb.de>
Message-ID: <20130122035028.GB29677@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 05:15:58PM +0000, Arnd Bergmann wrote:
> The dma and fiq portions of the imx-pcm driver both
> have a module_init() call, of which there can be only
> one in any given module. This changes Kconfig to enforce
> either the driver to be built-in in the kernel, or
> to have only one of the two when building imx-pcm as
> a module.
> 
> Without this patch, we cannot build the ARM 'allmodconfig', or
> we get this error:
> 
> sound/soc/fsl/imx-pcm-dma.o: In function `init_module':
> sound/soc/fsl/imx-pcm-dma.c:177: multiple definition of `init_module'
> sound/soc/fsl/imx-pcm-fiq.o:sound/soc/fsl/imx-pcm-fiq.c:334: first defined here
> sound/soc/fsl/imx-pcm-dma.o: In function `cleanup_module':
> sound/soc/fsl/imx-pcm-dma.c:177: multiple definition of `cleanup_module'
> sound/soc/fsl/imx-pcm-fiq.o:sound/soc/fsl/imx-pcm-fiq.c:334: first defined here
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: alsa-devel at alsa-project.org

I sent a fix [1] for that queued by Mark.

Mark,

Is the patch on the way to 3.8-rc?

Shawn

[1] http://thread.gmane.org/gmane.linux.alsa.devel/104434
