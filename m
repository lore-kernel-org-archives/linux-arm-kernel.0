From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 6 May 2014 13:49:43 +0200
Subject: [PATCH] ARM: dts: i.MX53: Fix ipu register space size
In-Reply-To: <1399374094-32451-1-git-send-email-s.hauer@pengutronix.de>
References: <1399374094-32451-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140506134943.4d87a726@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer wrote:
> The IPU register space is 128MB, not 2GB.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx53.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 9c2bff2..6a1bf4f 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -115,7 +115,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "fsl,imx53-ipu";
> -			reg = <0x18000000 0x080000000>;
> +			reg = <0x18000000 0x08000000>;
>
IMO this should be either 0x00800000 or 0x800000
while I prefer the first notation.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
