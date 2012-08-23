From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Aug 2012 10:07:48 +0800
Subject: [PATCH 3/6] ARM: imx: build pm-imx5 code only when PM is enabled
In-Reply-To: <1345648390-4234-4-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
 <1345648390-4234-4-git-send-email-arnd@arndb.de>
Message-ID: <20120823020746.GA24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 05:13:07PM +0200, Arnd Bergmann wrote:
> This moves the imx5 pm code out of the list of unconditionally
> compiled files for imx5, mirroring what we already do for imx6
> and how it was done before the code was move from mach-mx5 to
> mach-imx in v3.3.
> 
> Without this patch, building with CONFIG_PM disabled results in:
> 
> arch/arm/mach-imx/pm-imx5.c:202:116: error: redefinition of 'imx51_pm_init'
> arch/arm/mach-imx/include/mach-imx/common.h:154:91: note: previous definition of 'imx51_pm_init' was here
> arch/arm/mach-imx/pm-imx5.c:209:116: error: redefinition of 'imx53_pm_init'
> arch/arm/mach-imx/include/mach-imx/common.h:155:91: note: previous definition of 'imx53_pm_init' was here
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable at vger.kernel.org

Acked-by: Shawn Guo <shawn.guo@linaro.org>
