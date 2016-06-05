From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Sun, 5 Jun 2016 17:33:32 +0800
Subject: [PATCH v2,3/5] dt-bindings: mtu3: add devicetree bindings
In-Reply-To: <5751874C.9070100@gmail.com>
References: <1464673962-11506-1-git-send-email-chunfeng.yun@mediatek.com>
 <1464673962-11506-4-git-send-email-chunfeng.yun@mediatek.com>
 <5751874C.9070100@gmail.com>
Message-ID: <1465119212.11651.141.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-06-03 at 15:34 +0200, Matthias Brugger wrote:
> 
> On 31/05/16 07:52, Chunfeng Yun wrote:
> > add a DT binding doc for MediaTek USB3 DRD driver
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/usb/mtu3.txt |   85 ++++++++++++++++++++++++
> >   1 file changed, 85 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/usb/mtu3.txt
> >
> > diff --git a/Documentation/devicetree/bindings/usb/mtu3.txt b/Documentation/devicetree/bindings/usb/mtu3.txt
> > new file mode 100644
> > index 0000000..571ae8b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mtu3.txt
> 
> The file should be called mt8173-mtu3.txt to be in line with mt8173-xhci.txt
> Ok, I will rename it
> 
> > @@ -0,0 +1,85 @@
> > +The device node for Mediatek USB3.0 DRD controller
> > +
> > +Required properties:
> > + - compatible : should be "mediatek,mt8173-mtu3"
> > + - reg : specifies physical base address and size of the registers
> > + - reg-names: should be "mac" for device IP and "ippc" for IP port control
> > + - interrupts : interrupt used by the device IP
> > + - power-domains : a phandle to USB power domain node to control USB's
> > +	mtcmos
> > + - vusb33-supply : regulator of USB avdd3.3v
> > + - clocks : a list of phandle + clock-specifier pairs, one for each
> > +	entry in clock-names
> > + - clock-names : must contain "sys_ck" for clock of controller;
> > +	"wakeup_deb_p0" and "wakeup_deb_p1" are optional, they are
> > +	depends on "mediatek,enable-wakeup"
> > + - phys : a list of phandle + phy specifier pairs
> > + - dr_mode : should be one of "host", "peripheral" or "otg",
> > +	refer to usb/generic.txt
> > +
> > +Optional properties:
> > + - #address-cells, #size-cells : should be '2' if the device has sub-nodes
> > +	with 'reg' property
> > + - ranges : allows valid 1:1 translation between child's address space and
> > +	parent's address space
> > + - extcon : external connector for vbus and idpin changes detection, needed
> > +	when supports dual-role mode.
> > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > +	dual-role mode.
> > + - pinctl-names : a pinctrl state named "default" must be defined,
> > +	"id_float" and "id_ground" are optinal which depends on
> > +	"mediatek,enable-manual-drd"
> 
> So pinctrl is optional, but if you put it, you need at least "default"?
Yes, the first one is "default".

> 
> Apart from that, DT maintainers prefer to have the binding patches at 
> the beginning of a series, so it's easier for them to not oversee any.
> Ok.

Thanks a lot.
> Regards,
> Matthias
