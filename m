From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 26 Jul 2013 13:15:06 -0700
Subject: [PATCH v11] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1374834384-8071-1-git-send-email-p.zabel@pengutronix.de>
References: <1374834384-8071-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51F2D8CA.4010601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/13 03:26, Philipp Zabel wrote:
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +
> +struct gpio_reset_data {
> +	struct reset_controller_dev rcdev;
> +	unsigned int gpio;
> +	bool active_low;
> +	s32 delay_us;

Maybe I missed it, why is this signed? Do we plan to have negative time
delays?

>
> +
> +static struct reset_control_ops gpio_reset_ops = {

const?

> +	.reset = gpio_reset,
> +	.assert = gpio_reset_assert,
> +	.deassert = gpio_reset_deassert,
> +};
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
