From: pza@pengutronix.de (Philipp Zabel)
Date: Wed, 15 Oct 2014 00:38:00 +0200
Subject: [PATCH v2 2/3] ARM: meson: DTSI: Enable reset controller
In-Reply-To: <1413311749-13948-3-git-send-email-carlo@caione.org>
References: <1413311749-13948-1-git-send-email-carlo@caione.org>
 <1413311749-13948-3-git-send-email-carlo@caione.org>
Message-ID: <20141014223800.GB15055@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 08:35:48PM +0200, Carlo Caione wrote:
> Add the node for the reset controller in the DTSI.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/meson.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index e6539ea..1ca864e 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -75,6 +75,12 @@
>  			reg = <0xc1109900 0x8>;
>  		};
>  
> +		reset_AO: reset at c8100040 {
> +			#reset-cells = <1>;
> +			compatible = "amlogic,meson6-rst-mgr-ao";
> +			reg = <0xc8100040 0x4>;
> +		};
> +
>  		uart_AO: serial at c81004c0 {
>  			compatible = "amlogic,meson-uart";
>  			reg = <0xc81004c0 0x14>;

This needs to go through the same tree as the one meson.dtsi got included in.

regards
Philipp
