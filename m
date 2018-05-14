From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 14 May 2018 09:11:48 +0200
Subject: [PATCH] ARM: dts: socfpga: Fix NAND controller node compatible
In-Reply-To: <20180510125223.16056-1-marex@denx.de>
References: <20180510125223.16056-1-marex@denx.de>
Message-ID: <73h8nak8y3.fsf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Marek Vasut <marex@denx.de> writes:

> The compatible string for the Denali NAND controller is 
> incorrect,
> fix it by replacing it with one matching the DT bindings and the
> driver.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Fixes: d837a80d19 ("ARM: dts: socfpga: add nand controller 
> nodes")
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/socfpga.dtsi 
> b/arch/arm/boot/dts/socfpga.dtsi
> index 7e24dc8e82d4..d697f5062624 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -744,7 +744,7 @@
>  		nand0: nand at ff900000 {
>  			#address-cells = <0x1>;
>  			#size-cells = <0x1>;
> -			compatible = "denali,denali-nand-dt";
> +			compatible = "altr,socfpga-denali-nand";
>  			reg = <0xff900000 0x100000>,
>  			      <0xffb80000 0x10000>;
>  			reg-names = "nand_data", "denali_reg";

Ack. As the binding was changed after d837a80d19 this is obviously
correct.

@Dinh: Maybe you also want to cleanup the socfpga_arria10.dtsi? It 
has
both compatibles, but the "denali,denali-nand-dt" seems to be 
obsolete.

Thanks,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar 
|
Industrial Linux Solutions                 | 
http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: 
+49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax: 
+49-5121-206917-5555 |
