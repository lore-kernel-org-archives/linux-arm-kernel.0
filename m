From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 7 Mar 2017 12:27:23 +0300
Subject: [PATCH v2 1/6] ARM: dts: r8a73a4: Add INTC-SYS clock to device
 tree
In-Reply-To: <1488819491-26097-2-git-send-email-geert+renesas@glider.be>
References: <1488819491-26097-1-git-send-email-geert+renesas@glider.be>
 <1488819491-26097-2-git-send-email-geert+renesas@glider.be>
Message-ID: <183720b2-003c-efb6-e4b6-5e6151da46fe@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 3/6/2017 7:58 PM, Geert Uytterhoeven wrote:

> Link the ARM GIC to the INTC-SYS module clock and the C4 power domain,
> so it can be power managed using that clock in the future.
>
> Note that currently the GIC-400 driver doesn't support module clocks nor
> Runtime PM, so this must be handled as a critical clock.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add missing "power-domains" property,
>   - Add clock-names property,
>   - Drop RFC status,
>   - Change one-line summary prefix to match current arm-soc practices,
>   - s/GIC driver/GIC-400 driver/,
>   - Document critical clock dependency.
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi            | 13 +++++++++----
>  include/dt-bindings/clock/r8a73a4-clock.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 6fb7eaba91262edf..1f5c9f6dddba9366 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -467,6 +467,9 @@
>  			<0 0xf1004000 0 0x2000>,
>  			<0 0xf1006000 0 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		clocks = <&mstp4_clks R8A73A4_CLK_INTC_SYS>;
> +		clock-names = "clk";

    Do we really need such "clock-names"?

[...]

MBR, Sergei
