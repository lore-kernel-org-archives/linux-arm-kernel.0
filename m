From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 16 Mar 2015 11:21:12 +0100
Subject: [PATCH v2.0 1/2] pm: at91: add the PM initialization for the
 sama5d3 and sama5d4
In-Reply-To: <1425873428-8292-1-git-send-email-wenyou.yang@atmel.com>
References: <1425873378-8253-1-git-send-email-wenyou.yang@atmel.com>
 <1425873428-8292-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150316102112.GA29170@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Mon, Mar 09, 2015 at 11:57:08AM +0800, Wenyou Yang wrote:
> To get the mpddrc peripheral id from the PM initialization,
> which will be used to disable mpddrc'c clock during suspending.

> +void __init sam5d3_pm_init(void)
> +{
> +	at91_dt_ramc();
> +	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
> +	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
> +	at91_pm_data.ddrc_pid = SAMA5D3_ID_MPDDRC;
> +	return at91_pm_init();
> +}
> +
> +void __init sam5d4_pm_init(void)
> +{
> +	at91_dt_ramc();
> +	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
> +	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
> +	at91_pm_data.ddrc_pid = SAMA5D4_ID_MPDDRC;
> +	at91_pm_data.is_sama5d4 = true;
> +	return at91_pm_init();
> +}

> +static void __init sama5d4_dt_device_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	sam5d4_pm_init();
> +}

This doesn't look right, where is sam5d3_pm_init() actually used ?

Sylvain
