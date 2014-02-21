From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 21 Feb 2014 09:35:57 -0600
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <92B0AE30-5CDF-43FC-8588-EEF0C5F86266@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 20, 2014, at 6:38 PM, Bjorn Andersson <bjorn.andersson@sonymobile.com> wrote:

> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
> drivers/i2c/busses/Kconfig   |   10 +
> drivers/i2c/busses/Makefile  |    1 +
> drivers/i2c/busses/i2c-qup.c |  772 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 783 insertions(+)
> create mode 100644 drivers/i2c/busses/i2c-qup.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f5ed031..403e196 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -648,6 +648,16 @@ config I2C_PXA_SLAVE
> 	  is necessary for systems where the PXA may be a target on the
> 	  I2C bus.
> 
> +config I2C_QUP
> +	tristate "Qualcomm QUP based I2C controller"
> +	depends on ARCH_MSM

ARCH_QCOM

> +	help
> +	  If you say yes to this option, support will be included for the
> +	  built-in I2C interface on the Qualcomm SoCs.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-qup.
> +
> config I2C_RIIC
> 	tristate "Renesas RIIC adapter"
> 	depends on ARCH_SHMOBILE || COMPILE_TEST

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
