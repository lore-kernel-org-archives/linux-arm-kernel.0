From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 6 Oct 2014 14:40:15 +0200
Subject: [PATCH v7 10/11] ARM: at91/dt: add LCD panel description to
 sama5d3xdm.dtsi
In-Reply-To: <20141006142538.76d2df29@bbrezillon>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-11-git-send-email-boris.brezillon@free-electrons.com>
 <20141006110115.GH25202@ulmo> <20141006142538.76d2df29@bbrezillon>
Message-ID: <20141006124014.GD26833@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 02:25:38PM +0200, Boris Brezillon wrote:
> On Mon, 6 Oct 2014 13:01:16 +0200 Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Oct 01, 2014 at 04:53:07PM +0200, Boris Brezillon wrote:
> > [...]
> > > diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
[...]
> > > +		backlight = <&backlight>;
> > > +		power-supply = <&panel_reg>;
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +		status = "disabled";
> > > +
> > > +		port at 0 {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +
> > > +			panel_input: endpoint at 0 {
> > > +				reg = <0>;
> > > +				remote-endpoint = <&hlcdc_panel_output>;
> > > +			};
> > >  		};
> > 
> > There's no support for OF graphs in simple-panel, so this is unused,
> > isn't it?
> 
> Actually I use it in my atmel_hlcdc_ouput implementation to figure out
> the link between a panel and a device connected on the RGB/DPI bus. 

That's kind of weird and one of the reasons why I can't make myself like
the OF graph bindings. It requires drivers for one device to reach into
the device tree node of some other device and look for content. Or put
another way, a DT node for a panel that works on one platform doesn't
work on another because the display controller needs additional DT
content that isn't required by the original binding for the panel.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/596e701b/attachment.sig>
