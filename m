From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 28 Aug 2018 09:11:42 -0500
Subject: [PATCHv8 7/9] defconfig: enable fpga and service layer
In-Reply-To: <1535464245-11638-8-git-send-email-richard.gong@linux.intel.com>
References: <1535464245-11638-1-git-send-email-richard.gong@linux.intel.com>
 <1535464245-11638-8-git-send-email-richard.gong@linux.intel.com>
Message-ID: <54ccf9d5-1cf4-edf6-47c6-be7cc5badb3e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/28/2018 08:50 AM, richard.gong at linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Enable fpga framework, Stratix 10 SoC FPGA manager and Stratix10
> Service Layer
> 

Please update your commit header be "arm64: defconfig: enable fpga and
service layer"


> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> v3: no change
> v4: s/CONFIG_INTEL_SERVICE/CONFIG_STRATIX10_SERVICE/
>     add CONFIG_OF_FPGA_REGION=y
>     s/Intel/Stratix10/ in subject line
> v5: no change
> v6: no change
> v7: no change
> v8: no change
> ---
>  arch/arm64/configs/defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f67e8d5..2ad50a5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -185,6 +185,7 @@ CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_NBD=m
>  CONFIG_VIRTIO_BLK=y
>  CONFIG_BLK_DEV_NVME=m
> +CONFIG_STRATIX10_SERVICE=y

Can this be a module?

>  CONFIG_SRAM=y
>  CONFIG_EEPROM_AT25=m
>  # CONFIG_SCSI_PROC_FS is not set
> @@ -642,6 +643,12 @@ CONFIG_PHY_TEGRA_XUSB=y
>  CONFIG_HISI_PMU=y
>  CONFIG_QCOM_L2_PMU=y
>  CONFIG_QCOM_L3_PMU=y
> +CONFIG_MESON_EFUSE=m

What does this change have to do with this patch?

> +CONFIG_FPGA=y
> +CONFIG_FPGA_MGR_STRATIX10_SOC=y
> +CONFIG_FPGA_REGION=y
> +CONFIG_FPGA_BRIDGE=y
> +CONFIG_OF_FPGA_REGION=y

Can these be modules?

Dinh
