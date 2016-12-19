From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Dec 2016 09:46:52 +0100
Subject: [PATCH v2] ARM: dts: sun8i: add opp-v2 table for A33
In-Reply-To: <20161215182754.33921-1-icenowy@aosc.xyz>
References: <20161215182754.33921-1-icenowy@aosc.xyz>
Message-ID: <20161219084652.kiqdkiewu5tujlyd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 02:27:54AM +0800, Icenowy Zheng wrote:
> An operating point table is needed for the cpu frequency adjusting to
> work.
> 
> The operating point table is converted from the common value in
> extracted script.fex from many A33 board/tablets.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes since v1:
> - Fix format problem (blank lines).
> - Removed the 1.344GHz operating point, as it's overvoltage and overclocked.
> 
> This patch depends on the following patchset:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473962.html
> 
> It's the v2 of the [PATCH 4/6] in this patchset.
> 
> I think this operating point table may also apply to A23, as there's no
> difference except the points over 1.2GHz between A23 and A33's stock dvfs table.
> 
> But as A23 CCU may not have the necessary fixes, I won't add the table to A23
> now.
> 
> Chen-Yu, could you test the CCU fixes I described in the patchset above on A23,
> then test this operating points table?
> 
> If it's necessary, you can send out the CCU fixes and add one more patch that
> moves this opp-v2 table to sun8i-a23-a33.dtsi .
> 
>  arch/arm/boot/dts/sun8i-a33.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 504996cbee29..0f5b2af72981 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -46,7 +46,42 @@
>  #include <dt-bindings/dma/sun4i-a10.h>
>  
>  / {
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp at 648000000 {
> +			opp-hz = /bits/ 64 <648000000>;
> +			opp-microvolt = <1040000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp at 816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp at 1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1200000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp at 1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1320000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +	};
> +
>  	cpus {
> +		cpu0: cpu at 0 {

There's no need to duplicate the label here. I removed it and applied.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161219/73545705/attachment-0001.sig>
