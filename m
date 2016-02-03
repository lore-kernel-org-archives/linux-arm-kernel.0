From: dirk.behme@gmail.com (Dirk Behme)
Date: Wed, 3 Feb 2016 18:21:17 +0100
Subject: [PATCH v2] arm64: dts: r8a7795: Add L2 cache-controller nodes
In-Reply-To: <1452953856-5146-1-git-send-email-dirk.behme@gmail.com>
References: <1452953856-5146-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <56B2370D.2010102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.01.2016 15:17, Dirk Behme wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Add device nodes for the L2 caches, and link the CPU node to its L2
> cache node.
>
> The L2 cache for the Cortex-A57 CPU cores is 2 MiB large (organized as
> 128 KiB x 16 ways).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> ---
> Changes in v2: Dropped the not yet merged Cortex A53 part.
>
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index a82bce8..a22ae65 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -39,6 +39,7 @@
>   			compatible = "arm,cortex-a57", "arm,armv8";
>   			reg = <0x0>;
>   			device_type = "cpu";
> +			next-level-cache = <&L2_CA57>;
>   			enable-method = "psci";
>   		};
>
> @@ -46,22 +47,29 @@
>   			compatible = "arm,cortex-a57","arm,armv8";
>   			reg = <0x1>;
>   			device_type = "cpu";
> +			next-level-cache = <&L2_CA57>;
>   			enable-method = "psci";
>   		};
>   		a57_2: cpu at 2 {
>   			compatible = "arm,cortex-a57","arm,armv8";
>   			reg = <0x2>;
>   			device_type = "cpu";
> +			next-level-cache = <&L2_CA57>;
>   			enable-method = "psci";
>   		};
>   		a57_3: cpu at 3 {
>   			compatible = "arm,cortex-a57","arm,armv8";
>   			reg = <0x3>;
>   			device_type = "cpu";
> +			next-level-cache = <&L2_CA57>;
>   			enable-method = "psci";
>   		};
>   	};
>
> +	L2_CA57: cache-controller at 0 {
> +		compatible = "cache";
> +	};
> +
>   	extal_clk: extal {
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>


Any further comments to this? If not, could this be applied?

Best regards

Dirk
