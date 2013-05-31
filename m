From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 May 2013 09:51:03 +0800
Subject: [PATCH v7 08/11] ASoC: phycore-ac97: Add DT support
In-Reply-To: <1369925513-19329-9-git-send-email-mpa@pengutronix.de>
References: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
 <1369925513-19329-9-git-send-email-mpa@pengutronix.de>
Message-ID: <20130531015101.GA22536@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 04:51:50PM +0200, Markus Pargmann wrote:
> Add devicetree support for phycore-ac97 driver.
> 
> platform_of_node and cpu_of_node are set according to the fsl,audmux
> phandle.
> 
> This patch adds handling of ac97 reset functions according to fsl ac97
> support. They are setup from here to avoid board specific code in the
> generic fsl-ssi driver.
> 
> This patch changes the handling of pca100 boards from non-DT to DT only.
> pcm043 is still handled without DT.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Compiling phycore-ac97 as module,  I got the following errors.

  CC [M]  sound/soc/fsl/phycore-ac97.o
sound/soc/fsl/phycore-ac97.c:305:1: error: redefinition of ?__inittest?
sound/soc/fsl/phycore-ac97.c:146:1: note: previous definition of ?__inittest? was here
sound/soc/fsl/phycore-ac97.c:305:1: error: redefinition of ?init_module?
sound/soc/fsl/phycore-ac97.c:146:1: note: previous definition of ?init_module? was here
sound/soc/fsl/phycore-ac97.c:305:1: error: redefinition of ?__exittest?
sound/soc/fsl/phycore-ac97.c:147:1: note: previous definition of ?__exittest? was here
sound/soc/fsl/phycore-ac97.c:305:1: error: redefinition of ?cleanup_module?
sound/soc/fsl/phycore-ac97.c:147:1: note: previous definition of ?cleanup_module? was here
make[4]: *** [sound/soc/fsl/phycore-ac97.o] Error 1

Shawn
