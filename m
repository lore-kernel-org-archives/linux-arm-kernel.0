From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Jun 2014 15:24:19 +0200
Subject: [PATCH v9 4/5] ARM: sunxi: Add IR controllers on A20 to dtsi
In-Reply-To: <1402250893-5412-5-git-send-email-bay@hackerdom.ru>
References: <1402250893-5412-1-git-send-email-bay@hackerdom.ru>
 <1402250893-5412-5-git-send-email-bay@hackerdom.ru>
Message-ID: <20140616132419.GA9757@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 09, 2014 at 12:08:12AM +0600, Alexander Bersenev wrote:
> This patch adds records for two IR controllers on A20
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index c057c3e..fe1f8ff 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -763,6 +763,24 @@
>  			interrupts = <0 24 4>;
>  		};
>  
> +		ir0: ir at 01c21800 {
> +			compatible = "allwinner,sun7i-a20-ir";
> +			clocks = <&apb0_gates 6>, <&ir0_clk>;
> +			clock-names = "apb", "ir";
> +			interrupts = <0 5 4>;
> +			reg = <0x01c21800 0x40>;
> +			status = "disabled";
> +		};
> +
> +		ir1: ir at 01c21c00 {
> +			compatible = "allwinner,sun7i-a20-ir";
> +			clocks = <&apb0_gates 7>, <&ir1_clk>;
> +			clock-names = "apb", "ir";
> +			interrupts = <0 6 4>;
> +			reg = <0x01c21c00 0x40>;
> +			status = "disabled";
> +		};
> +
>  		lradc: lradc at 01c22800 {
>  			compatible = "allwinner,sun4i-lradc-keys";
>  			reg = <0x01c22800 0x100>;

I'm fine with this patch, but it doesn't apply, since the above node
doesn't exist. Please rebase on top of v3.16-rc1 and resend the patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140616/2a8c3068/attachment.sig>
