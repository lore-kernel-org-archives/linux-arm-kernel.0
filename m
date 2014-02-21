From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Feb 2014 11:06:37 +0000
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140221110637.GG7541@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 12:38:10AM +0000, Bjorn Andersson wrote:
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
>  drivers/i2c/busses/Kconfig   |   10 +
>  drivers/i2c/busses/Makefile  |    1 +
>  drivers/i2c/busses/i2c-qup.c |  772 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 783 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-qup.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f5ed031..403e196 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -648,6 +648,16 @@ config I2C_PXA_SLAVE
>           is necessary for systems where the PXA may be a target on the
>           I2C bus.

[...]

> +static const struct of_device_id qup_i2c_dt_match[] = {
> +       { .compatible = "qcom,i2c-qup-v1.1.1" },
> +       { .compatible = "qcom,i2c-qup-v2.1.1" },
> +       { .compatible = "qcom,i2c-qup-v2.2.1" },

The all seem to be handled the same.

Are they all compatible with the "qcom,i2c-qup-v1.1.1" programming
model, such that it could be used as a fallback in the compatible list
(and the driver would only need to look for it for now)?

Cheers,
Mark.
