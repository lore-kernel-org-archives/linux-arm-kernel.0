From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 29 Oct 2015 17:42:43 +0900
Subject: [PATCH v5 2/5] arm64: dts: r8a7795: add EthernetAVB device node
In-Reply-To: <1444891698-8780-3-git-send-email-horms+renesas@verge.net.au>
References: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
 <1444891698-8780-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoQLXQENVxvpMB_pymu7B+F6MhL0CBqPC4EscFTxOYt07Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 3:48 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> [horms: minor updates]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
> v0 [Kazuya Mizuguchi]
>
> v1 [Simon Horman]
> * moved to soc node
> * updated patch subject
>
> v2 [Simon Horman]
> * Specify all interrupts
> * Use named interrupts
> * Rebase
> * Remove spurious whitespace change introduce in v1
>
> v3 [Simon Horman]
> * As suggested by Geert Uytterhoeven
>   - Add power-domains property
> * Added Ack
>
> v4, v5
> * No change
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 6efa49f97e07..63bc74e89fa4 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -312,6 +312,48 @@
>                         /* Empty node for now */
>                 };
>
> +               avb: ethernet at e6800000 {
> +                       compatible = "renesas,etheravb-r8a7795";
> +                       reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
> +                       interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "ch0", "ch1", "ch2", "ch3",
> +                                         "ch4", "ch5", "ch6", "ch7",
> +                                         "ch8", "ch9", "ch10", "ch11",
> +                                         "ch12", "ch13", "ch14", "ch15",
> +                                         "ch16", "ch17", "ch18", "ch19",
> +                                         "ch20", "ch21", "ch22", "ch23",
> +                                         "ch24";
> +                       clocks = <&mstp8_clks R8A7795_CLK_ETHERAVB>;
> +                       power-domains = <&cpg_clocks>;
> +                       phy-mode = "rgmii-id";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
>                 dmac1: dma-controller at e7300000 {
>                         /* Empty node for now */
>                 };
> --
> 2.1.4
>

Hi Simon,

Thanks for your efforts with the ethernet controller. In general all
seems good to me, but this I came across the contents of this patch
when I was browsing the SoC DTSI file. What is the reason to put this
node in between dmac0 and dmac1? I don't know where is the best
location, but it would be good to keep the dmac nodes together I
think.

Cheers,

/ magnus
