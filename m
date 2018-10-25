From: robh@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 13:30:03 -0500
Subject: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
In-Reply-To: <f71d442412f31828c466e3483e9d42f5e96ddc1d.camel@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io>
 <1886367.eljNk7jKYl@avalon>
 <c68f0da9607805e1f6673a9a16a7dcfff4d8fe91.camel@aosc.io>
 <2778638.na8ndVNUfi@avalon>
 <f71d442412f31828c466e3483e9d42f5e96ddc1d.camel@aosc.io>
Message-ID: <20181025183003.GA12672@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 08:40:11PM +0800, Icenowy Zheng wrote:
> ? 2018-10-18?? 14:23 +0300?Laurent Pinchart???
> > Hi Icenowy,
> > 
> > On Thursday, 18 October 2018 13:00:05 EEST Icenowy Zheng wrote:
> > > ? 2018-10-18?? 11:53 +0300?Laurent Pinchart???
> > > > On Thursday, 18 October 2018 10:33:22 EEST Icenowy Zheng wrote:
> > > > > The ANX6345 is an ultra-low power DisplayPort/eDP transmitter
> > > > > designed
> > > > > for portable devices.
> > > > > 
> > > > > Add a binding document for it.
> > > > > 
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > ---
> > > > > 
> > > > >  .../bindings/display/bridge/anx6345.txt       | 39
> > > > > +++++++++++++++++++
> > > > > 
> > > > >  1 file changed, 39 insertions(+)
> > > > >  create mode 100644
> > > > > 
> > > > > Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > new
> > > > > file
> > > > > mode 100644
> > > > > index 000000000000..0689d4eb5f65
> > > > > --- /dev/null
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > @@ -0,0 +1,39 @@
> > > > > +Analogix ANX6345 eDP Transmitter
> > > > > +--------------------------------
> > > > > +
> > > > > +The ANX6345 is an ultra-low power Full-HD eDP transmitter
> > > > > designed
> > > > > for
> > > > > +portable devices.
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > + - compatible		: "analogix,anx6345"
> > > > > + - reg			: I2C address of the device
> > > > > + - reset-gpios		: Which GPIO to use for reset
> > > > > +
> > > > > +Optional properties:
> > > > > +
> > > > > + - dvdd12-supply	: Regulator for 1.2V digital core
> > > > > power.
> > > > > + - dvdd25-supply	: Regulator for 2.5V digital core
> > > > > power.
> > > > 
> > > > Shouldn't these to supplies be mandatory ?
> > > 
> > > Yes they should.
> > > 
> > > > > + - panel-supply		: Regulator for the power of
> > > > > the panel.
> > > > 
> > > > Shouldn't the panel supply for specified in the DT node of the
> > > > panel
> > > > ?
> > > 
> > > However, eDP panel can be probed, may vary on the same device, and
> > > we
> > > don't have a generic binding for it...
> > 
> > Shouldn't we fix that ? :-)
> 
> Maybe we should create a connector binding instead of a panel binding?

There's not any such thing as a standard eDP connector, is there? 
Otherwise, that's just creating a generic panel binding in disguise. 
Maybe if eDP interface is standardized enough in terms of power control, 
control lines, EDID at least sometimes present, etc., then we could have 
some sort of generic eDP panel/connector binding.

Rob
