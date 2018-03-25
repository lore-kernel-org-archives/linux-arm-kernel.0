From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 25 Mar 2018 16:09:13 +0200
Subject: [PATCH 4/7] ARM: dts: sun7i: Add pinmux settings for LCD0
 RGB888 output.
In-Reply-To: <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <1521986953.5301.4.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mercredi 21 mars 2018 ? 21:03 +0100, Giulio Benetti a ?crit :
> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
> for the needed pins.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
> b/arch/arm/boot/dts/sun7i-a20.dtsi
> index efb5607..bfe6728 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -922,6 +922,14 @@
>  				pins = "PI20", "PI21";
>  				function = "uart7";
>  			};
> +
> +			lcd0_rgb888_pins: lcd0-rgb888-pins {

It would be more consistent with other pins definitions to have
underscores in both names and to indicate the index, such as:
lcd0_rgb888_pins: lcd0_rgb888_pins at 0 {

This way, other set of pins for LCD (PH0-PH27) can be declared as @1
when they are needed in the future.

> +				pins = "PD0", "PD1", "PD2", "PD3",
> "PD4", "PD5", "PD6", "PD7",
> +				       "PD8", "PD9", "PD10", "PD11",
> "PD12", "PD13", "PD14", "PD15",
> +				       "PD16", "PD17", "PD18",
> "PD19", "PD20", "PD21", "PD22", "PD23",
> +				       "PD24", "PD25", "PD26",
> "PD27";
> +				function = "lcd0";
> +			};
>  		};
>  
>  		timer at 1c20c00 {

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180325/54c13b55/attachment-0001.sig>
