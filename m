From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Jan 2016 00:33:47 -0800
Subject: [PATCH v4 07/13] ARM: at91: pm: find and remap the pmc
In-Reply-To: <1453911072-23608-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1453911072-23608-8-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160128083347.GL12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27, Alexandre Belloni wrote:
> @@ -399,13 +400,33 @@ static void __init at91_pm_sram_init(void)
>  			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
>  }
>  
> +static __initconst struct of_device_id atmel_pmc_ids[] = {

The kbuild error is weird, but __initconst should come right
before the equals sign (=). Plus it should actually be const.

> +	{ .compatible = "atmel,at91rm9200-pmc"  },
> +	{ .compatible = "atmel,at91sam9260-pmc" },
> +	{ .compatible = "atmel,at91sam9g45-pmc" },
> +	{ .compatible = "atmel,at91sam9n12-pmc" },
> +	{ .compatible = "atmel,at91sam9x5-pmc" },
> +	{ .compatible = "atmel,sama5d3-pmc" },
> +	{ .compatible = "atmel,sama5d2-pmc" },
> +	{ /* sentinel */ },
> +};
> +
>  static void __init at91_pm_init(void)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
