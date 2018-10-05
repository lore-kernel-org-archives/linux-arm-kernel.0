From: nm@ti.com (Nishanth Menon)
Date: Fri, 5 Oct 2018 10:03:50 -0500
Subject: [PATCH] arm64: defconfig: Enable TI_SCI related configs
In-Reply-To: <20181005100330.16914-1-lokeshvutla@ti.com>
References: <20181005100330.16914-1-lokeshvutla@ti.com>
Message-ID: <20181005150350.yj7irr6z4yaff3m7@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:03-20181005, Lokesh Vutla wrote:
> Enable TI System Control Interface (TI_SCI) Message Protocol library
> and it's relevant power management drivers using this library.
> 
> TI's AM6 SoC uses this TI_SCI library to communicate to its system
> controller(DMSC). While at it, enable TI_MESSAGE_MANAGER mailbox driver
> using which this communication happens.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> - Based on next tag: next-20181005
> 
>  arch/arm64/configs/defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0baf31ca069f..4b3844480a77 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -118,6 +118,7 @@ CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
>  CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
> +CONFIG_TI_SCI_PROTOCOL=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> @@ -593,6 +594,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
>  CONFIG_COMMON_CLK_S2MPS11=y
>  CONFIG_CLK_QORIQ=y
>  CONFIG_COMMON_CLK_PWM=y
> +CONFIG_TI_SCI_CLK=y
>  CONFIG_COMMON_CLK_QCOM=y
>  CONFIG_QCOM_CLK_SMD_RPM=y
>  CONFIG_IPQ_GCC_8074=y
> @@ -604,6 +606,7 @@ CONFIG_HWSPINLOCK_QCOM=y
>  CONFIG_ARM_MHU=y
>  CONFIG_PLATFORM_MHU=y
>  CONFIG_BCM2835_MBOX=y
> +CONFIG_TI_MESSAGE_MANAGER=y
>  CONFIG_QCOM_APCS_IPC=y
>  CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_TEGRA_IOMMU_SMMU=y
> @@ -624,6 +627,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
>  CONFIG_ARCH_TEGRA_194_SOC=y
>  CONFIG_ARCH_K3_AM6_SOC=y
>  CONFIG_SOC_TI=y
> +CONFIG_TI_SCI_PM_DOMAINS=y
>  CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>  CONFIG_EXTCON_USB_GPIO=y
>  CONFIG_EXTCON_USBC_CROS_EC=y
> @@ -643,6 +647,7 @@ CONFIG_PWM_RCAR=m
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_PWM_SAMSUNG=y
>  CONFIG_PWM_TEGRA=m
> +CONFIG_RESET_TI_SCI=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_PHY_SUN4I_USB=y
>  CONFIG_PHY_HI6220_USB=y
> -- 
> 2.19.0
> 
Thanks Lokesh,

Olof, any chance to pick this up for v4.20?

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
