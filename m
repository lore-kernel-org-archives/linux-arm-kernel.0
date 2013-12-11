From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 15:49:13 +0100
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <1386770541-15056-3-git-send-email-zhangfei.gao@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
 <1386770541-15056-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <201312111549.14017.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
> ---
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   51 ++++++++
>  drivers/mmc/host/Kconfig                           |   10 ++
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/dw_mmc-k3.c                       |  136 ++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-k3.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> new file mode 100644
> index 000000000000..d816b89c386a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -0,0 +1,51 @@
> +* Hisilicon specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +Read synopsys-dw-mshc.txt for more details
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the Hisilicon specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following.
> +  - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extentions.
> +* clk-table-num: should be number of clks in clk-table required by each mmc timing
> +* clk-table: should clock list required by each mmc timing

I have not seen "clk-table" and "clk-table-num" before. Are these standard
properties? What are the units that are used here, what does the index mean?

	Arnd
