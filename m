From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Tue, 14 Jul 2015 14:19:51 +0800
Subject: [PATCH v2 1/5] dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
In-Reply-To: <20150710051018.GU18700@pengutronix.de>
References: <1436348468-4126-1-git-send-email-chunfeng.yun@mediatek.com>
 <1436348468-4126-2-git-send-email-chunfeng.yun@mediatek.com>
 <20150710051018.GU18700@pengutronix.de>
Message-ID: <1436854791.11289.11.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
On Fri, 2015-07-10 at 07:10 +0200, Sascha Hauer wrote:
> On Wed, Jul 08, 2015 at 05:41:03PM +0800, Chunfeng Yun wrote:
> > add a DT binding documentation of usb3.0 phy for MT65xx
> > SoCs from Mediatek.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mt65xx-u3phy.txt       | 34 ++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt b/Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
> > new file mode 100644
> > index 0000000..056b2aa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
> > @@ -0,0 +1,34 @@
> > +MT65xx U3PHY
> > +
> > +The device node for Mediatek SOC usb3.0 phy
> > +
> > +Required properties:
> > + - compatible : Should be "mediatek,mt8173-u3phy"
> > + - reg        : Offset and length of registers, the first is for mac domain,
> > +	another for phy domain
> > + - power-domains: to enable usb's mtcmos
> > + - usb-wakeup-ctrl : to access usb wakeup control register
> > + - wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup mode; others
> > +	means don't enable wakeup source of usb
> > + - u2port-num : number of usb2.0 ports to support which should be 1 or 2
> > + - clocks     : must support all clocks that phy need
> > + - clock-names: should be "wakeup_deb_p0", "wakeup_deb_p1" for wakeup
> > +	debounce control clocks, and "u3phya_ref" for u3phya reference clock.
> > +
> > +Example:
> > +
> > +u3phy: usb-phy at 11271000 {
> > +	compatible = "mediatek,mt8173-u3phy";
> > +	reg = <0 0x11271000 0 0x3000>,
> > +	      <0 0x11280000 0 0x20000>;
> 
> 0x11271000 is the register space the xhci controller takes. You should
> not expose the same register space to two different drivers.
> 

usb: usb30 at 11270000 {
   compatible = "mediatek,mt8173-xhci";
   reg = <0 0x11270000 0 0x1000>;

the size of xhci register space is 0x1000, and the range is
[0x11270000, 0x11271000 - 1], so the address of 0x11271000 is not
included.

> Sascha
> 
