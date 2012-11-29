From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 29 Nov 2012 12:36:05 +0000
Subject: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
In-Reply-To: <1354121939-11246-5-git-send-email-zonque@gmail.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com>
 <1354121939-11246-5-git-send-email-zonque@gmail.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA0B986@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 22:28:59, Daniel Mack wrote:
[...]
> +	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
> +		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
> +			if (!strcasecmp(s, nand_ecc_opts[val])) {
> +				gpmc_nand_data->ecc_opt = val;
> +				break;
> +			}
> +
> +		/*
> +		 *  AM335x RBL compatibility mode - dependns on runtime
> +		 * detection of the error location module.
> +		 */
> +		if (!strcasecmp(s, "bch8-am335xrbl-compatible")) {
> +			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
> +			gpmc_nand_data->is_elm_used = true;

Remove is_elm_used from struct omap_nand_platform_data. Now this data
populated as part of run time detection of elm module. So please remove
The usage of is_elm_used;

http://www.spinics.net/lists/arm-kernel/msg210549.html

Thanks
Avinash 
> 
