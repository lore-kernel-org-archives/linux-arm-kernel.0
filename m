From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 May 2015 10:07:49 +0200
Subject: [PATCH v3 1/6] rtc: arm: imx: snvs: change use syscon to access
 register
In-Reply-To: <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
 <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150522080749.GI3244@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This looks good to me, a few nits below

On 22/05/2015 at 00:16:47 +0800, Frank.Li at freescale.com wrote :
> -	spin_unlock_irqrestore(&data->lock, flags);
> +	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR,
> +			  (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
That line is not properly aligned (missing one space)

[...]

> +	if (of_device_is_compatible(snvs_np, "syscon")) {
> +		data->regmap = syscon_node_to_regmap(snvs_np);
> +		data->offset = 0x34;
> +	} else {
> +		pr_warning("snvs rtc: you use old dts file, please update it\n");

This should be pr_warn()


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
