From: nm@ti.com (Nishanth Menon)
Date: Wed, 29 Jul 2015 14:37:44 -0500
Subject: [PATCH 12/17] ARM: dts: am57xx-beagle-x15: Fix regulator populated
 in MMC1 dt node
In-Reply-To: <1438168187-1614-13-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
 <1438168187-1614-13-git-send-email-kishon@ti.com>
Message-ID: <55B92B88.1080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2015 06:09 AM, Kishon Vijay Abraham I wrote:
> For beagle x15, both the vdd and io lines are connected to the
> same regulator (ldo1_reg). However vmmc_aux is populated to vdd_3v3.
> Remove it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index a63bf78..d0db5c5 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -579,7 +579,6 @@
>  	pinctrl-0 = <&mmc1_pins_default>;
>  
>  	vmmc-supply = <&ldo1_reg>;
> -	vmmc_aux-supply = <&vdd_3v3>;
>  	pbias-supply = <&pbias_mmc_reg>;
>  	bus-width = <4>;
>  	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
> 
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
