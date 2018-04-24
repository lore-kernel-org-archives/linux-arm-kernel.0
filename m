From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 23 Apr 2018 20:25:49 -0700
Subject: [PATCH v5 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <1524524972-12014-3-git-send-email-rishabhb@codeaurora.org>
References: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
 <1524524972-12014-3-git-send-email-rishabhb@codeaurora.org>
Message-ID: <4856aba7-4a06-eb15-57d5-abfd28f8a15f@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2018 04:09 PM, Rishabh Bhatnagar wrote:

> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e050eb8..2b09321 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -21,6 +21,23 @@ config QCOM_GSBI
>            functions for connecting the underlying serial UART, SPI, and I2C
>            devices to the output pins.
> 
> +config QCOM_LLCC
> +	tristate "Qualcomm Technologies, Inc. LLCC driver"
> +	depends on ARCH_QCOM
> +	help
> +	  Qualcomm Technologies, Inc. platform specific
> +	  Last Level Cache Controller(LLCC) driver. This provides interfaces
> +	  to client's that use the LLCC. Say yes here to enable LLCC slice

	  to clients

> +	  driver.
> +
> +config QCOM_SDM845_LLCC
> +	tristate "Qualcomm Technologies, Inc. SDM845 LLCC driver"
> +	depends on QCOM_LLCC
> +	help
> +	  Say yes here to enable the LLCC driver for SDM845. This provides
> +	  data required to configure LLCC so that clients can start using the
> +	  LLCC slices.
> +
>  config QCOM_MDT_LOADER
>  	tristate
>  	select QCOM_SCM


-- 
~Randy
