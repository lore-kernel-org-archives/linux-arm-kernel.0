From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Aug 2014 10:23:58 +0100
Subject: [RFC] arm64: Add cpu-return-addr to dts files
In-Reply-To: <1408132229.22761.66.camel@smoke>
References: <1408132130.22761.64.camel@smoke> <1408132229.22761.66.camel@smoke>
Message-ID: <20140818092357.GB14559@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 08:50:29PM +0100, Geoff Levand wrote:
> Add entries for the new device tree property cpu-return-addr to the
> existing arm64 dts files.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> 
> Just FYI.
> 
>  arch/arm64/boot/dts/apm-storm.dtsi     | 8 ++++++++
>  arch/arm64/boot/dts/foundation-v8.dts  | 4 ++++
>  arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> index 40aa96c..c40e25f 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -25,6 +25,7 @@
>  			reg = <0x0 0x000>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x1 0x0000fff8>;
> +			cpu-return-addr = <0x0 0x0>; /* Updated by bootloader */

Following from the way we handle PSCI in the bootwrapper, if we were to
support these I expect we'd inject the proeprties entirely. So there's
no need to have a property with an invalid value here -- the property
should be valid if present (consider that zero could be a valid PA to
jump back to).

Cheers,
Mark.
