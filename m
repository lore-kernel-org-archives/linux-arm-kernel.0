From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 10 Aug 2012 17:18:33 -0600
Subject: [PATCH 2/2] ARM: nomadik: configure Nomadik for pin control
In-Reply-To: <1344552220-995-1-git-send-email-linus.walleij@linaro.org>
References: <1344552220-995-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <502596C9.4010900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2012 04:43 PM, Linus Walleij wrote:
> This converts the Nomadik to using pin control using the
> driver for the STN8815 ASIC.

> diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c

> +static inline void
> +cpu8815_add_pinctrl(struct device *parent, const char *name)
> +{
> +	struct platform_device_info pdevinfo = {
> +		.parent = parent,
> +		.name = name,
> +		.id = -1,
> +	};
> +
> +	platform_device_register_full(&pdevinfo);
> +}

Out of curiosity, why platform_device_register_full() not
platform_device_register() here?

Otherwise,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
