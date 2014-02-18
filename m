From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Feb 2014 10:19:44 +0800
Subject: [PATCH] ARM: mach-imx: Select CONFIG_SRAM at ARCH_MXC level
In-Reply-To: <1392656657-25594-1-git-send-email-fabio.estevam@freescale.com>
References: <1392656657-25594-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140218021943.GB15716@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 02:04:17PM -0300, Fabio Estevam wrote:
> Booting a mx6q system built with multi_v7_defconfig leads to the following
> error messages on boot:
> 
> [    0.037758] imx6q_ocram_suspend_init: ocram pool unavailable!
> [    0.037768] imx6_pm_common_init: failed to initialize ocram suspend -19!
> 
> This happens because CONFIG_SRAM is not selected by default in 
> multi_v7_defconfig.
> 
> Fix this by selecting CONFIG_SRAM at ARCH_MXC level, so that other SoCs could
> use the SRAM driver as well.
> 
> As SRAM automatically selects GENERIC_ALLOCATOR, just drop it from the Kconfig
> entry.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks. 
