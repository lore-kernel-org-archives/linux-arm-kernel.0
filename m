From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Tue, 17 Jan 2017 14:00:58 +0000
Subject: [PATCH 3/4] arm64: dts: r8a7795: Link ARM GIC to clock and clock
 domain
In-Reply-To: <1484657360-13101-4-git-send-email-geert+renesas@glider.be>
References: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
 <1484657360-13101-4-git-send-email-geert+renesas@glider.be>
Message-ID: <HK2PR06MB05451777E7151CA9C7EF8990C37C0@HK2PR06MB0545.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> Subject: [PATCH 3/4] arm64: dts: r8a7795: Link ARM GIC to clock and clock
> domain
> 
> Link the ARM GIC to the INTC-AP module clock, and add it to the SYSC
> "always-on" PM Domain, so it can be power managed using that clock.
> 
> Note that currently the GIC-400 driver doesn't support module clocks nor
> Runtime PM, so this must be handled as a critical clock.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 026a16ac41b422a1..0627df2a0b810c86 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -166,6 +166,9 @@
>  			      <0x0 0xf1060000 0 0x20000>;
>  			interrupts = <GIC_PPI 9
>  					(GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&cpg CPG_MOD 408>;
> +			clock-names = "clk";

Should the module clock be named "fck"?

Thanks,
Ramesh
