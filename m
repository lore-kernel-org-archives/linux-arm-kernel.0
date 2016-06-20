From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Jun 2016 00:05:02 +0300
Subject: [PATCH v4 13/13] ARM: dts: r8a7793: Add APMU node and second CPU
 core
In-Reply-To: <1466072862-28030-14-git-send-email-geert+renesas@glider.be>
References: <1466072862-28030-1-git-send-email-geert+renesas@glider.be>
 <1466072862-28030-14-git-send-email-geert+renesas@glider.be>
Message-ID: <d862ed53-b57b-47b7-f783-bbeceb6eae3e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 01:27 PM, Geert Uytterhoeven wrote:

> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add DT nodes for the Advanced Power Management Unit (APMU) and the
> second CPU core.  Use the enable-method to point out that the APMU
> should be used for SMP support.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - Improve patch description,
>   - Use "renesas,<soctype>-apmu" instead of "renesas,apmu-<soctype>",
>
> v3:
>   - New.
> ---
>  arch/arm/boot/dts/r8a7793.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index 9b55c1c6ee31a49d..fce310c54efa88eb 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
[...]
> @@ -56,6 +57,13 @@
>  			next-level-cache = <&L2_CA15>;
>  		};
>
> +		cpu1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <1>;
> +			clock-frequency = <1500000000>;

    Why no "power-domains??

[...]

MBR, Sergei
