From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 15 Mar 2017 14:06:24 +0300
Subject: [PATCH v2 14/20] ARM64: dts: sun50i-a64: Add dt node for the
 syscon control module
In-Reply-To: <20170314141856.24560-15-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
 <20170314141856.24560-15-clabbe.montjoie@gmail.com>
Message-ID: <f8d389b4-c98a-684d-9df6-6197458cf1d7@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 3/14/2017 5:18 PM, Corentin Labbe wrote:

> This patch add the dt node for the syscon register present on the
> Allwinner A64.
>
> Only two register are present in this syscon and the only one useful is
> the one dedicated to EMAC clock.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1c64ea2..3b09af2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -121,6 +121,12 @@
>  		#size-cells = <1>;
>  		ranges;
>
> +		syscon: syscon at 01c00000 {
> +			compatible = "syscon",
> +				"allwinner,sun8i-h3-system-controller";

    the right order of values in this prop is from more to less specific.

[...]

MBR, Sergei
