From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 11 Aug 2017 15:01:17 +0800
Subject: [PATCH 4/4] dt-bindings: mt8173-xhci: add generic compatible
 and rename file
In-Reply-To: <20170811025617.s3wuqlkgjvgc4exi@rob-hp-laptop>
References: <8f0cb0047b2aa195d818ad686cbbceabb3ad91a0.1502170518.git.chunfeng.yun@mediatek.com>
 <ed176bd0af123ad6a94982c628bb70a6a3bf7515.1502170518.git.chunfeng.yun@mediatek.com>
 <20170811025617.s3wuqlkgjvgc4exi@rob-hp-laptop>
Message-ID: <1502434877.25536.126.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-08-10 at 21:56 -0500, Rob Herring wrote:
> On Tue, Aug 08, 2017 at 01:42:52PM +0800, Chunfeng Yun wrote:
> > The mt8173-xhci.txt actually holds the bindings for all mediatek
> > SoCs with xHCI controller, so add a generic compatible and change
> > the name to xhci-mtk.txt to reflect that.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../bindings/usb/{mt8173-xhci.txt => xhci-mtk.txt} |   10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >  rename Documentation/devicetree/bindings/usb/{mt8173-xhci.txt => xhci-mtk.txt} (92%)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/xhci-mtk.txt
> > similarity index 92%
> > rename from Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > rename to Documentation/devicetree/bindings/usb/xhci-mtk.txt
> 
> mediatek,mtk-xhci.txt
Ok
> 
> > index 0acfc8a..1ce77c7 100644
> > --- a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > +++ b/Documentation/devicetree/bindings/usb/xhci-mtk.txt
> > @@ -11,7 +11,9 @@ into two parts.
> >  ------------------------------------------------------------------------
> >  
> >  Required properties:
> > - - compatible : should contain "mediatek,mt8173-xhci"
> > + - compatible : should be one of
> > +	"mediatek,mt8173-xhci" (deprecated, use "mediatek,xhci-mtk" instead),
> 
> NAK for same reason.
It's backward compatible
> 
> > +	"mediatek,xhci-mtk"
> 
> mediatek,mtk-xhci would be more in line with conventions.
Ok
> 
> >   - reg : specifies physical base address and size of the registers
> >   - reg-names: should be "mac" for xHCI MAC and "ippc" for IP port control
> >   - interrupts : interrupt used by the controller
> > @@ -68,10 +70,12 @@ usb30: usb at 11270000 {
> >  
> >  In the case, xhci is added as subnode to mtu3. An example and the DT binding
> >  details of mtu3 can be found in:
> > -Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
> > +Documentation/devicetree/bindings/usb/mtu3.txt
> >  
> >  Required properties:
> > - - compatible : should contain "mediatek,mt8173-xhci"
> > + - compatible : should be one of
> > +	"mediatek,mt8173-xhci" (deprecated, use "mediatek,xhci-mtk" instead),
> > +	"mediatek,xhci-mtk"
> >   - reg : specifies physical base address and size of the registers
> >   - reg-names: should be "mac" for xHCI MAC
> >   - interrupts : interrupt used by the host controller
> > -- 
> > 1.7.9.5
> > 
