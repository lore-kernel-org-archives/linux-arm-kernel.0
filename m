From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Wed, 7 Sep 2016 19:51:48 +0200
Subject: [PATCH 5/6] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <20160831081817.5191-6-maxime.ripard@free-electrons.com>
Message-ID: <20160907175148.c3fioqbr2k2pdqri@x1-6-00-0f-9f-c6-3e-90.cpe.webspeed.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> From: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>
> The GR8 is an SoC made by Nextthing loosely based on the sun5i family.
>
> Since it's not clear yet what we can factor out and merge with the A10s and
> A13 support, let's keep it out of the sun5i.dtsi include tree. We will
> figure out what can be shared when things settle down.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/gr8.dtsi | 1080 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1080 insertions(+)
>  create mode 100644 arch/arm/boot/dts/gr8.dtsi
>
> diff --git a/arch/arm/boot/dts/gr8.dtsi b/arch/arm/boot/dts/gr8.dtsi
> new file mode 100644
> index 000000000000..d21cfa3f3c14
> --- /dev/null
> +++ b/arch/arm/boot/dts/gr8.dtsi

In the node names, you sometimes use underscores and sometimes use hyphens.
Here are the ones I spotted:

> +               osc3M: osc3M_clk {
> +               pll3x2: pll3x2_clk {
> +               pll7x2: pll7x2_clk {
> +       display-engine {
> +               sram-controller at 01c00000 {
> +                               otg_sram: sram-section at 0000 {
> +               dma: dma-controller at 01c02000 {
> +               tve0: tv-encoder at 01c0a000 {
> +               tcon0: lcd-controller at 01c0c000 {
> +               intc: interrupt-controller at 01c20400 {
> +                       lcd_rgb666_pins: lcd_rgb666 at 0 {
> +                       nand_pins_a: nand_base0 at 0 {
> +                       nand_cs0_pins_a: nand_cs at 0 {
> +                       nand_rb0_pins_a: nand_rb at 0 {
> +                       uart1_cts_rts_pins_a: uart1-cts-rts at 0 {
> +               fe0: display-frontend at 01e00000 {
> +               be0: display-backend at 01e60000 {

Underscores should not be used in node names. [1][2] Since you're adding a
new file here, please use hyphens instead.

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
[2] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

-- 
Rask Ingemann Lambertsen
