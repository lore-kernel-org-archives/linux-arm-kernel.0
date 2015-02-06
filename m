From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 06 Feb 2015 10:18:12 +0900
Subject: [PATCH v5 0/2] mmc: dw_mmc: exynos: Add HS400 support
In-Reply-To: <1422499318-13726-1-git-send-email-alim.akhtar@samsung.com>
References: <1422499318-13726-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <54D41654.8030702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Alim.

On my board, this patch isn't working fine.
So when i complete to test on my board(exynos5), i will reply with comments.
Sorry for late testing.

Best Regards,
Jaehoon Chung

On 01/29/2015 11:41 AM, Alim Akhtar wrote:
> This adds HS400 mode support for exynos dw_mmc host controller.
> 
> Currently tested on Exynos5800-peach-pi and Exyons7 platform for HS400 mode.
> Tested HS200 mode with this series applied, HS200 still works.
> 
> Appreciate testing on other exynos5/7 platform which supports emmc5.0
> 
> Changes in V5:
> 	* Enable HS400 on Exynos5800-peach-pi boards
> 	* Addressed other review comments from Jaehoon Chung
> 
> Changes in V4:
> 	* drop the idea of changing existing binding for ciu_div as per [1]
>         * addressed comments from Jaehoon Chung [2]
> 
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg40923.html
> [2] http://www.spinics.net/lists/devicetree/msg64373.html
> 
> Changes in V3:
> 	rebased on ulf's next (commit: 607b448 mmc: core: Make tuning block patterns static)
> 
> Seungwon Jeon (2):
>   mmc: dw_mmc: exynos: Support eMMC's HS400 mode
>   ARM: dts: Add HS400 support for exynos5420 and exynos5800
> 
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    7 +
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |    4 +-
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 +-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |    7 +-
>  drivers/mmc/host/dw_mmc-exynos.c                   |  185 ++++++++++++++++----
>  drivers/mmc/host/dw_mmc-exynos.h                   |   19 +-
>  drivers/mmc/host/dw_mmc.c                          |   16 +-
>  drivers/mmc/host/dw_mmc.h                          |    2 +
>  9 files changed, 213 insertions(+), 38 deletions(-)
> 
