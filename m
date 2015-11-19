From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 19 Nov 2015 11:36:51 +0800
Subject: [PATCH v12 1/3] dt-bindings: Add a binding for Mediatek xHCI
 host controller
In-Reply-To: <564B085B.7060706@cogentembedded.com>
References: <1447751921-26746-1-git-send-email-chunfeng.yun@mediatek.com>
 <1447751921-26746-2-git-send-email-chunfeng.yun@mediatek.com>
 <564B085B.7060706@cogentembedded.com>
Message-ID: <1447904211.18917.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Tue, 2015-11-17 at 13:58 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/17/2015 12:18 PM, Chunfeng Yun wrote:
> 
> > add a DT binding documentation of xHCI host controller for the
> > MT8173 SoC from Mediatek.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   .../devicetree/bindings/usb/mt8173-xhci.txt        | 51 ++++++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> >
> > diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > new file mode 100644
> > index 0000000..a78f20b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> > @@ -0,0 +1,51 @@
> > +MT8173 xHCI
> > +
> > +The device node for Mediatek SOC USB3.0 host controller
> > +
> > +Required properties:
> > + - compatible : should contain "mediatek,mt8173-xhci"
> > + - reg : specifies physical base address and size of the registers,
> > +	the first one for MAC, the second for IPPC
> > + - interrupts : interrupt used by the controller
> > + - power-domains : a phandle to USB power domain node to control USB's
> > +	mtcmos
> 
>     What's that?
It works as a gateway in fact which can turn on/off usb power
> 
> > + - vusb33-supply : regulator of USB avdd3.3v
> > +
> > + - clocks : a list of phandle + clock-specifier pairs, one for each
> > +	entry in clock-names
> > + - clock-names : must contain
> > +	"sys_ck": for clock of xHCI MAC
> > +	"wakeup_deb_p0": for USB wakeup debounce clock of port0
> > +	"wakeup_deb_p0": for USB wakeup debounce clock of port1
> 
>     "wakeup_deb_p1"?
Yes, it's a typo
> 
> > +
> > + - phys : a list of phandle + phy specifier pairs
> > +
> > +Optional properties:
> > + - mediatek,wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup
>                                 ^^ IP?
Ok
> 
> > +	mode;
> > + - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
> > +	control register, it depends on "mediatek,wakeup-src".
> > + - vbus-supply : reference to the VBUS regulator;
> > + - usb3-lpm-capable : supports USB3.0 LPM
> 
> [...]
> 
> MBR, Sergei
> 
