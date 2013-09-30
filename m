From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Sep 2013 10:27:55 +0000 (UTC)
Subject: [PATCH v4 06/11] ARM: OMAP2+: PM: AM43x powerdomain data
In-Reply-To: <a3264d8cfea31ba2418ee015b772bef6d5a7ca0a.1380179370.git.afzal@ti.com>
References: <cover.1380179370.git.afzal@ti.com>
 <a3264d8cfea31ba2418ee015b772bef6d5a7ca0a.1380179370.git.afzal@ti.com>
Message-ID: <alpine.DEB.2.02.1309301025500.17980@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Sep 2013, Afzal Mohammed wrote:

> From: Ambresh K <ambresh@ti.com>
> 
> Add the data file to describe all power domains in AM43x SoC.
> OMAP4 powerdomain operations is being reused here.
> 
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

...

> --- /dev/null
> +++ b/arch/arm/mach-omap2/powerdomains43xx_data.c
> @@ -0,0 +1,142 @@

...

> +static struct powerdomain per_43xx_pwrdm = {
> +	.name		  = "per_pwrdm",
> +	.voltdm		  = { .name = "core" },
> +	.prcm_offs	  = AM43XX_PRM_PER_INST,
> +	.prcm_partition	  = AM43XX_PRM_PARTITION,
> +	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret = PWRSTS_OFF_RET,
> +	.banks		  = 4,
> +	.pwrsts_mem_ret	= {
> +		[0] = PWRSTS_OFF_RET,	/* icss_mem */
> +		[1] = PWRSTS_OFF_RET,	/* per_mem */
> +		[2] = PWRSTS_OFF_RET,	/* ram1_mem */
> +		[3] = PWRSTS_OFF_RET,	/* ram2_mem */
> +	},
> +	.pwrsts_mem_on	= {
> +		[0] = PWRSTS_OFF_RET,	/* icss_mem */
> +		[1] = PWRSTS_ON,	/* per_mem */
> +		[2] = PWRSTS_OFF_RET,	/* ram1_mem */
> +		[3] = PWRSTS_OFF_RET,	/* ram2_mem */
> +	},
> +	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
> +};

The pwrsts_mem_on flags don't make any sense here for banks 0, 2, and 3.  
They claim that those banks can never be turned on.  Could you please 
doublecheck these?



- Paul
