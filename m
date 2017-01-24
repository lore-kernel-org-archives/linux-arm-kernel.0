From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Jan 2017 08:22:49 +0000
Subject: [PATCH 2/7] MFD: add STM32 DFSDM support
In-Reply-To: <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20170124082249.GR16020@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jan 2017, Arnaud Pouliquen wrote:

> DFSDM hardware IP can be used at the same time for ADC sigma delta

Same time as what?

> conversion and audio PDM microphone.
> MFD driver is in charge of configuring IP registers and managing IP clocks.
> For this it exports an API to handles filters and channels resources.

This looks like an ADC driver?  What is it that makes it an MFD?

> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/mfd/Kconfig             |   11 +
>  drivers/mfd/Makefile            |    2 +
>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
>  5 files changed, 1601 insertions(+)
>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
>  create mode 100644 drivers/mfd/stm32-dfsdm.c
>  create mode 100644 include/linux/mfd/stm32-dfsdm.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c6df644..4bb660b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1607,6 +1607,17 @@ config MFD_STW481X
>  	  in various ST Microelectronics and ST-Ericsson embedded
>  	  Nomadik series.
>  
> +config MFD_STM32_DFSDM
> +	tristate "ST Microelectronics STM32 DFSDM"
> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the STM32 Digital Filter
> +	  for Sigma Delta Modulators (DFSDM) driver used
> +	  in various STM32 series.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
