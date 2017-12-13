From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 10:11:32 +0000
Subject: [PATCH 2/3] ARM: configs: stm32: Enable ARM_MPU
In-Reply-To: <1513101746-18030-3-git-send-email-alexandre.torgue@st.com>
References: <1513101746-18030-1-git-send-email-alexandre.torgue@st.com>
 <1513101746-18030-3-git-send-email-alexandre.torgue@st.com>
Message-ID: <5d8f2c2f-ca2e-632e-bac6-29299dda724e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/17 18:02, Alexandre Torgue wrote:
> STM32 MCUs embed a Memory Protection Unit. Enabling this setting will
> allow the Kernel to configure the MPU according to devicetree.

Would it be better to "select ARM_MPU" for machines with Cortex-M7?

Vladimir

> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index bb358ff..e642bdf9 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SET_MEM_PARAM=y
>  CONFIG_DRAM_BASE=0x90000000
>  CONFIG_FLASH_MEM_BASE=0x08000000
>  CONFIG_FLASH_SIZE=0x00200000
> +CONFIG_ARM_MPU=y
>  CONFIG_PREEMPT=y
>  # CONFIG_ATAGS is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
> 
