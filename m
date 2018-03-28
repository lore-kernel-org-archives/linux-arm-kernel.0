From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 28 Mar 2018 12:03:51 +1100
Subject: [PATCH] dts: ARM: Add Aspeed virtual hub to SoC templates
In-Reply-To: <CACPK8XdgoNLr3m_bp_Y+Cu6pNx5f0xJ5BwWL8svZPgM-YNQA8w@mail.gmail.com>
References: <1515739918.31850.102.camel@kernel.crashing.org>
 <CACPK8XdgoNLr3m_bp_Y+Cu6pNx5f0xJ5BwWL8svZPgM-YNQA8w@mail.gmail.com>
Message-ID: <1522199031.7364.82.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-28 at 11:00 +1030, Joel Stanley wrote:
> Hi Ben,
> 
> On 12 January 2018 at 17:21, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > We don't yet enable it in any of the boards
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This one slipped through the cracks. Is it still the latest version?

I was going to re-submit it after the driver itself is in.

> 
> Cheers,
> 
> Joel
> 
> > ---
> >  arch/arm/boot/dts/aspeed-g4.dtsi |  8 ++++++++
> >  arch/arm/boot/dts/aspeed-g5.dtsi | 13 +++++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> > index e55f2ad5de59..743b79014d3d 100644
> > --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> > @@ -120,6 +120,14 @@
> >                         status = "disabled";
> >                 };
> > 
> > +               vhub: usb-vhub at 1e6a0000 {
> > +                       compatible = "aspeed,ast2400-usb-vhub";
> > +                       reg = <0x1e6a0000 0x300>;
> > +                       interrupts = <5>;
> > +                       clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                       status = "disabled";
> > +               };
> > +
> >                 apb {
> >                         compatible = "simple-bus";
> >                         #address-cells = <1>;
> > diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> > index 655258edee24..e50d7f3e18a0 100644
> > --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> > @@ -163,6 +163,14 @@
> >                         status = "disabled";
> >                 };
> > 
> > +               vhub: usb-vhub at 1e6a0000 {
> > +                       compatible = "aspeed,ast2500-usb-vhub";
> > +                       reg = <0x1e6a0000 0x300>;
> > +                       interrupts = <5>;
> > +                       clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                       status = "disabled";
> > +               };
> > +
> >                 apb {
> >                         compatible = "simple-bus";
> >                         #address-cells = <1>;
> > @@ -1388,6 +1396,11 @@
> >                 groups = "USB2AH";
> >         };
> > 
> > +       pinctrl_usb2ad_default: usb2ad_default {
> > +               function = "USB2AD";
> > +               groups = "USB2AD";
> > +       };
> > +
> >         pinctrl_usb11bhid_default: usb11bhid_default {
> >                 function = "USB11BHID";
> >                 groups = "USB11BHID";
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
