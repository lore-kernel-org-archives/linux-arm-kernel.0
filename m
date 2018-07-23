From: peda@axentia.se (Peter Rosin)
Date: Mon, 23 Jul 2018 08:12:17 +0200
Subject: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
In-Reply-To: <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
Message-ID: <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
> +		/* Handle the remaining bytes which were not sent */
> +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +		       OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {

You moved the OWL_ line to the left instead of right, so this is still
misaligned and thus not helping the reader.

Cheers,
Peter

> +			writel(msg->buf[i2c_dev->msg_ptr++],
> +			       i2c_dev->base + OWL_I2C_REG_TXDAT);
> +		}
