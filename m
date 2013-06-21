From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Jun 2013 17:43:52 +0100
Subject: [PATCH 1/3] clk: Add APM X-Gene SoC clock driver for
 reference, PLL, and device clocks.
In-Reply-To: <1371828605-18053-2-git-send-email-lho@apm.com>
References: <1371828605-18053-1-git-send-email-lho@apm.com>
 <1371828605-18053-2-git-send-email-lho@apm.com>
Message-ID: <20130621164352.GC25228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 04:30:03PM +0100, Loc Ho wrote:
> clk: Add APM X-Gene SoC clock driver for reference, PLL, and device clocks.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/clk/Kconfig     |    7 +
>  drivers/clk/Makefile    |    1 +
>  drivers/clk/clk-xgene.c |  538 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 546 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/clk-xgene.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 0357ac4..aa4d8b6 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -81,6 +81,13 @@ config COMMON_CLK_AXI_CLKGEN
>           Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
>           FPGAs. It is commonly used in Analog Devices' reference designs.
> 
> +config COMMON_CLK_XGENE
> +       bool "Clock driver for APM XGene SoC"
> +       default y
> +       depends on ARCH_XGENE
> +       ---help---
> +         Sypport for the APM X-Gene SoC reference, PLL, and device clocks.

Like the recent vexpress changes, you can make this depend on ARM64
only.

-- 
Catalin
