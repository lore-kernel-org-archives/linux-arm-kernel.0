From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 13:35:34 +0100
Subject: [PATCH v2 2/5] dts: sun8i-h3: Add APB0 related clocks and resets
In-Reply-To: <1454448113-18810-3-git-send-email-k@japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-3-git-send-email-k@japko.eu>
Message-ID: <20160203123534.GG4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 02, 2016 at 10:21:50PM +0100, Krzysztof Adamski wrote:
> APB0 is bearly mentioned in H3 User Manual and it is only setup in the
> Allwinners kernel dump for CIR. I have verified experimentally that the
> gate for R_PIO exists and works, though. There are probably other gates
> there but I don't know their order right now and I don't have access to
> their peripherals on my board to test them.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 1524130e..ce35e93 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -276,6 +276,32 @@
>  			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
>  			clock-output-names = "mbus";
>  		};
> +
> +		ahb0: ahb0_clk {
> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +			clock-div = <1>;
> +			clock-mult = <1>;
> +			clocks = <&osc24M>, <&osc32k>;
> +			clock-output-names = "ahb0";
> +		};

I'm not sure what you mean there. The fixed factor clocks only take a
single parent, and you provided two.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/1086294a/attachment.sig>
