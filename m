From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 May 2015 10:38:52 +0200
Subject: [PATCH 6/6] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock/reset controllers
In-Reply-To: <20150501012039.GG32407@codeaurora.org>
References: <1429778143-2074-1-git-send-email-s.hauer@pengutronix.de>
 <1429778143-2074-7-git-send-email-s.hauer@pengutronix.de>
 <20150501012039.GG32407@codeaurora.org>
Message-ID: <20150504083852.GJ4946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 06:20:39PM -0700, Stephen Boyd wrote:
> On 04/23, Sascha Hauer wrote:
> > This adds the binding documentation for the apmixedsys, perisys and
> > infracfg controllers found on Mediatek SoCs.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Please Cc devicetree reviewers on bindings (CCed now).
> 
> > ---
> >  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  | 23 +++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,infracfg.txt    | 30 ++++++++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,pericfg.txt     | 30 ++++++++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,topckgen.txt    | 23 +++++++++++++++++
> >  4 files changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > new file mode 100644
> > index 0000000..5af6d73
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > @@ -0,0 +1,23 @@
> > +Mediatek apmixedsys controller
> > +==============================
> > +
> > +The Mediatek apmixedsys controller provides the PLLs to the system.
> > +
> > +Required Properties:
> > +
> > +- compatible: Should be:
> > +	- "mediatek,mt8135-apmixedsys"
> > +	- "mediatek,mt8173-apmixedsys"
> > +- #clock-cells: Must be 1
> > +
> > +The apmixedsys controller uses the common clk binding from
> > +Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> > +
> > +Example:
> > +
> > +apmixedsys: apmixedsys at 10209000 {
> 
> apmixedsys: clock-controller at 10209000 {
> 
> would be more standard. The same comment applies throughout this
> patch. Otherwise it looks good to me.

For apmixed this I agree, but the others are also reset controllers, so
I'm not sure if clock-controller is appropriate. Personally I don't care
much, I'll change to whatever you like.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
