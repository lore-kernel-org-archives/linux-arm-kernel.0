From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 15 Dec 2017 10:58:51 -0800
Subject: [PATCH v7 5/6] arm64: dts: meson-axg: add clock DT info for Meson
 AXG SoC
In-Reply-To: <20171211141348.22048-6-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Mon, 11 Dec 2017 22:13:47 +0800")
References: <20171211141348.22048-1-yixun.lan@amlogic.com>
 <20171211141348.22048-6-yixun.lan@amlogic.com>
Message-ID: <7h7etnakd0.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> From: Qiufang Dai <qiufang.dai@amlogic.com>
>
> Try to add Hiubus DT info, and also enable clock DT info
> for the Amlogic's Meson-AXG SoC.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to v4.16/dt64,

Thanks,

Kevin

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b932a784b02a..6fe5ee0c144e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -148,6 +148,20 @@
>  			#address-cells = <0>;
>  		};
>  
> +		hiubus: bus at ff63c000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xff63c000 0x0 0x1c00>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
> +
> +			clkc: clock-controller at 0 {
> +				compatible = "amlogic,axg-clkc";
> +				#clock-cells = <1>;
> +				reg = <0x0 0x0 0x0 0x320>;
> +			};
> +		};
> +
>  		mailbox: mailbox at ff63dc00 {
>  			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
>  			reg = <0 0xff63dc00 0 0x400>;
