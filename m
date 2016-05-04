From: nm@ti.com (Nishanth Menon)
Date: Wed, 4 May 2016 14:50:36 -0500
Subject: [PATCH] ARM: dts: omap5-board-common: Describe the voltage supply
 mapping accurately
In-Reply-To: <1462389618-28860-1-git-send-email-nm@ti.com>
References: <1462389618-28860-1-git-send-email-nm@ti.com>
Message-ID: <572A528C.4090302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2016 02:20 PM, Nishanth Menon wrote:
[...]

> @@ -551,6 +590,8 @@
>  
>  				ldo9_reg: ldo9 {
>  					/* VCC_DV_SDIO: vdds_sdcard */
> +					vin-supply = <&vmmcsdio_fixed>;
> +

There is an extra white space here, and vmmcsd_fixed is the regulator
to be used, looks like vmmcsdio_fixed should ideally been vwlan_fixed
or something.. the actual rail to LDO9_IN was called vmmc_3v3_SDIO..

Sorry for the confusion. Unfortunately, I can not recreate the fail on
my board, but this sounded like the closest fix I can think of.




-- 
Regards,
Nishanth Menon
