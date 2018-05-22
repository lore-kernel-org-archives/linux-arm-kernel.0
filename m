From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 15:09:50 -0500
Subject: [PATCH 4/5] arm64: allwinner: h6: add USB3 device nodes
In-Reply-To: <9a25a561-b643-a77b-3287-8082780fce60@cogentembedded.com>
References: <20180507151817.55663-1-icenowy@aosc.io>
 <20180507151817.55663-5-icenowy@aosc.io>
 <9a25a561-b643-a77b-3287-8082780fce60@cogentembedded.com>
Message-ID: <20180522200950.GA16392@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 11:31:27AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 5/7/2018 6:18 PM, Icenowy Zheng wrote:
> 
> > Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
> > a custom PHY.
> > 
> > Add device tree nodes for them.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >   arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index c72da8cd9ef5..9564c938717c 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -174,6 +174,44 @@
> >   			status = "disabled";
> >   		};
> > +		usb3: usb at 5200000 {
> 
>    I don't think <unit-address> is allowed for a node having no "reg" prop...

Right. One way to fix is fill out ranges property because the unit 
address can come from either.

However, there's work to deprecate doing DWC3 binding with a child node 
like this. See the series "usb: dwc3: support clocks and resets for DWC3 
core". Please follow that.

Rob
