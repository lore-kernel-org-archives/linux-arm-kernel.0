From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 20:12:54 +0100
Subject: [PATCH 4/6] ARM: dts: sun8i: add opp-v2 table for A33
In-Reply-To: <20161213152252.53749-5-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
 <20161213152252.53749-5-icenowy@aosc.xyz>
Message-ID: <20161213191254.pgcuvrpnebgw666g@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 11:22:50PM +0800, Icenowy Zheng wrote:
> An operating point table is needed for the cpu frequency adjusting to
> work.
> 
> The operating point table is converted from the common value in
> extracted script.fex from many A33 board/tablets.
> 
> 1.344GHz is set as a turbo-mode operating point, as it's described as
> "extremity_freq" in the FEX file. (the "max_freq" is 1.2GHz)
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 504996cbee29..035c058324b8 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -46,7 +46,45 @@
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

Please add new lines between the nodes.

> +		opp at 816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp at 1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1200000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp at 1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1320000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp at 1344000000 {
> +			opp-hz = /bits/ 64 <1344000000>;
> +			opp-microvolt = <1460000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			turbo-mode;
> +		};

As far as I know, this OPP is not used by Allwinner, is not usable in
any A33 board so far (both the A33-olinuxino and the SinA33 do not
allow such a voltage on their CPU regulator), and overvolting and
overclocking is something that is very risky, and might lead to
stability issues.

Please remove this OPP.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/9b08b536/attachment.sig>
