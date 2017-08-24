From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 24 Aug 2017 11:48:14 +0200
Subject: [PATCH 3/4] arm: dts: gr-peach: Add ETHER pin group
In-Reply-To: <1503564523-31899-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1503564523-31899-1-git-send-email-jacopo+renesas@jmondi.org>
 <1503564523-31899-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdUoMU=qN3Qjoqmf6uxcS3j5hqthhuBDMPZzA+wSD_BH5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Thu, Aug 24, 2017 at 10:48 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add pin configuration subnode for ETHER pin group.
> The interface can be configured and probed, but no traffic can be
> transmitted or received.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> ---
> When in u-boot console I can ping a connected host, after the
> system has booted I can configure an ip address on the interface but
> cannot exchange any traffic.
> I have compared the pin configuration procedure with the u-boot
> implemented one and some sketches from mbed operating system libraries,
> the configured pins are correct and registers values seems to match.
> Not sure if this patch should be sent for inclusion but sending it out
> anyway for you to judge this.
>
> Thanks
>    j
> ---
>  arch/arm/boot/dts/r7s72100-gr-peach.dts | 35 +++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
> index bcfa644..5ce558f 100644
> --- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
> +++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
> @@ -58,6 +58,28 @@
>                 /* P6_2 as RxD2; P6_3 as TxD2 */
>                 pinmux = <RZA1_PINMUX(6, 2, 7)>, <RZA1_PINMUX(6, 3, 7)>;
>         };
> +
> +       ether_pins: ether {
> +               /* Ethernet on Ports 1,3,5,10 */
> +               pinmux = <RZA1_PINMUX(1, 14, 4)>, /* P1_14 = ET_COL   */
> +                        <RZA1_PINMUX(3, 0, 2)>,  /* P3_0 = ET_TXCLK  */
> +                        <RZA1_PINMUX(3, 3, 2)>,  /* P3_3 = ET_MDIO   */
> +                        <RZA1_PINMUX(3, 4, 2)>,  /* P3_4 = ET_RXCLK  */
> +                        <RZA1_PINMUX(3, 5, 2)>,  /* P3_5 = ET_RXER   */
> +                        <RZA1_PINMUX(3, 6, 2)>,  /* P3_6 = ET_RXDV   */
> +                        <RZA1_PINMUX(5, 9, 2)>,  /* P5_9 = ET_MDC    */
> +                        <RZA1_PINMUX(10, 1, 4)>, /* P10_1 = ET_TXER  */
> +                        <RZA1_PINMUX(10, 2, 4)>, /* P10_2 = ET_TXEN  */
> +                        <RZA1_PINMUX(10, 3, 4)>, /* P10_3 = ET_CRS   */
> +                        <RZA1_PINMUX(10, 4, 4)>, /* P10_4 = ET_TXD0  */
> +                        <RZA1_PINMUX(10, 5, 4)>, /* P10_5 = ET_TXD1  */
> +                        <RZA1_PINMUX(10, 6, 4)>, /* P10_6 = ET_TXD2  */
> +                        <RZA1_PINMUX(10, 7, 4)>, /* P10_7 = ET_TXD3  */
> +                        <RZA1_PINMUX(10, 8, 4)>, /* P10_8 = ET_RXD0  */
> +                        <RZA1_PINMUX(10, 9, 4)>, /* P10_9 = ET_RXD1  */
> +                        <RZA1_PINMUX(10, 10, 4)>,/* P10_10 = ET_RXD2 */
> +                        <RZA1_PINMUX(10, 11, 4)>;/* P10_11 = ET_RXD3 */

All OK, but do you need P4_2, which is used for ET_nRST?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
