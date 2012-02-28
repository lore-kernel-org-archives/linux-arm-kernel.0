From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 28 Feb 2012 13:14:35 -0800
Subject: [PATCH v3 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <1329923841-32017-7-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-7-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E63@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Wednesday, February 22, 2012 8:17 AM:
> This commit adds a generic PWM framework driver for the PWFM controller
> found on NVIDIA Tegra SoCs. The driver is based on code from the
> Chromium kernel tree and was originally written by Gary King (NVIDIA)
> and later modified by Simon Que (Chromium).

> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c

> +static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,

> +	/*
> +	 * Convert from duty_ns / period_ns to a fixed number of duty
> +	 * ticks per (1 << PWM_DUTY_WIDTH) cycles.
> +	 */
> +	c = duty_ns * ((1 << PWM_DUTY_WIDTH) - 1);

The driver in ChromeOS has the following extra line here:

    c += (period_ns / 2);

and the following extra line in the comment above:

    Also, make sure to round to the nearest integer during division.

I don't know the HW well enough to know if that line should be present?

Otherwise, this looks similar enough to the ChromeOS driver, so:

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
