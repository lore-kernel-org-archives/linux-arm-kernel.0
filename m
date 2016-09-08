From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 12:00:31 +0200
Subject: [PATCH 5/6] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <20160907175148.c3fioqbr2k2pdqri@x1-6-00-0f-9f-c6-3e-90.cpe.webspeed.dk>
References: <20160831081817.5191-6-maxime.ripard@free-electrons.com>
 <20160907175148.c3fioqbr2k2pdqri@x1-6-00-0f-9f-c6-3e-90.cpe.webspeed.dk>
Message-ID: <20160908100031.GO8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 07:51:48PM +0200, Rask Ingemann Lambertsen wrote:
> On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > From: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> >
> > The GR8 is an SoC made by Nextthing loosely based on the sun5i family.
> >
> > Since it's not clear yet what we can factor out and merge with the A10s and
> > A13 support, let's keep it out of the sun5i.dtsi include tree. We will
> > figure out what can be shared when things settle down.
> >
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/gr8.dtsi | 1080 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 1080 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/gr8.dtsi
> >
> > diff --git a/arch/arm/boot/dts/gr8.dtsi b/arch/arm/boot/dts/gr8.dtsi
> > new file mode 100644
> > index 000000000000..d21cfa3f3c14
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/gr8.dtsi
> 
> In the node names, you sometimes use underscores and sometimes use hyphens.
> Here are the ones I spotted:
> 
> > +               osc3M: osc3M_clk {
> > +               pll3x2: pll3x2_clk {
> > +               pll7x2: pll7x2_clk {
> > +       display-engine {
> > +               sram-controller at 01c00000 {
> > +                               otg_sram: sram-section at 0000 {
> > +               dma: dma-controller at 01c02000 {
> > +               tve0: tv-encoder at 01c0a000 {
> > +               tcon0: lcd-controller at 01c0c000 {
> > +               intc: interrupt-controller at 01c20400 {
> > +                       lcd_rgb666_pins: lcd_rgb666 at 0 {
> > +                       nand_pins_a: nand_base0 at 0 {
> > +                       nand_cs0_pins_a: nand_cs at 0 {
> > +                       nand_rb0_pins_a: nand_rb at 0 {
> > +                       uart1_cts_rts_pins_a: uart1-cts-rts at 0 {
> > +               fe0: display-frontend at 01e00000 {
> > +               be0: display-backend at 01e60000 {
> 
> Underscores should not be used in node names. [1][2] Since you're adding a
> new file here, please use hyphens instead.

I wonder what the rationale behind this is. The ePAPR clearly
documents the underscore as being a valid character for the node
names.

I'll change the few inconsistencies though.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/aae07d1e/attachment.sig>
