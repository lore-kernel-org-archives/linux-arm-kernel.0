From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Jan 2013 22:53:10 +0800
Subject: [PATCH 1/2] ARM i.MX6: Add regulator delay support
In-Reply-To: <1359585224-11304-1-git-send-email-b20788@freescale.com>
References: <1359585224-11304-1-git-send-email-b20788@freescale.com>
Message-ID: <20130130145308.GF2757@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 05:33:44PM -0500, Anson Huang wrote:
> For ANATOP LDOs, vddcpu, vddsoc and vddpu
> have step time settings in the misc2 register, need
> to add necessary step time info for these three LDOs,
> then regulator driver can add necessary delay based on
> these settings.
> 
> offset 0x170:
> bit [24-25]: vddcpu
> bit [26-27]: vddpu
> bit [28-29]: vddsoc
> 
> field definition:
> 0'b00: 64 cycles of 24M clock;
> 0'b01: 128 cycles of 24M clock;
> 0'b02: 256 cycles of 24M clock;
> 0'b03: 512 cycles of 24M clock;
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Looks good.  Will apply after the driver part gets accepted.

Shawn

> ---
>  arch/arm/boot/dts/imx6q.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index d6265ca..a2e977d 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -480,6 +480,9 @@
>  					anatop-reg-offset = <0x140>;
>  					anatop-vol-bit-shift = <0>;
>  					anatop-vol-bit-width = <5>;
> +					anatop-delay-reg-offset = <0x170>;
> +					anatop-delay-bit-shift = <24>;
> +					anatop-delay-bit-width = <2>;
>  					anatop-min-bit-val = <1>;
>  					anatop-min-voltage = <725000>;
>  					anatop-max-voltage = <1450000>;
> @@ -494,6 +497,9 @@
>  					anatop-reg-offset = <0x140>;
>  					anatop-vol-bit-shift = <9>;
>  					anatop-vol-bit-width = <5>;
> +					anatop-delay-reg-offset = <0x170>;
> +					anatop-delay-bit-shift = <26>;
> +					anatop-delay-bit-width = <2>;
>  					anatop-min-bit-val = <1>;
>  					anatop-min-voltage = <725000>;
>  					anatop-max-voltage = <1450000>;
> @@ -508,6 +514,9 @@
>  					anatop-reg-offset = <0x140>;
>  					anatop-vol-bit-shift = <18>;
>  					anatop-vol-bit-width = <5>;
> +					anatop-delay-reg-offset = <0x170>;
> +					anatop-delay-bit-shift = <28>;
> +					anatop-delay-bit-width = <2>;
>  					anatop-min-bit-val = <1>;
>  					anatop-min-voltage = <725000>;
>  					anatop-max-voltage = <1450000>;
> -- 
> 1.7.9.5
> 
> 
