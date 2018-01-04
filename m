From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 20:44:36 +0100
Subject: [PATCH v5 01/12] dt-bindings: panel: lvds: Document power-supply
 property
In-Reply-To: <2493504.1OPucrC18r@avalon>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
 <0a6a3abcf1a6b7f0e66a81af8a44c5c0566ce06c.1513854122.git-series.maxime.ripard@free-electrons.com>
 <2493504.1OPucrC18r@avalon>
Message-ID: <20180104194436.reka6nw5hf32o4p3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Dec 22, 2017 at 02:08:20PM +0200, Laurent Pinchart wrote:
> Hi Maxime,
> 
> Thank you for the patch.
> 
> On Thursday, 21 December 2017 13:02:27 EET Maxime Ripard wrote:
> > The power-supply property is used by a vast majority of panels, including
> > panel-simple. Let's document it as a common property
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/display/panel/panel-common.txt | 6 ++++++
> > Documentation/devicetree/bindings/display/panel/panel-lvds.txt   | 1 +
> > Documentation/devicetree/bindings/display/panel/simple-panel.txt | 2 +- 3
> > files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> > b/Documentation/devicetree/bindings/display/panel/panel-common.txt index
> > ec52c472c845..125ea68052af 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> > @@ -78,6 +78,12 @@ used for panels that implement compatible control
> > signals. while active. Active high reset signals can be supported by
> > inverting the GPIO specifier polarity flag.
> > 
> > +Power
> > +-----
> > +
> > +- power-supply: many display panels need an additional power supply in
> > +  order to be fully powered-up. For such panels, power-supply contains
> > +  a phandle to the regulator powering the panel.
> 
> I think we should give more details here about the limitations of this 
> property. How about the following explanation ?
> 
> - power-supply: display panels require power to be supplied. While several 
> panels need more than one power supply with panel-specific constraints 
> governing the order and timings of the power supplies, in many cases a single 
> power supply is sufficient, either because the panel has a single power rail, 
> or because all its power rails can be driven by the same supply. In that case 
> the power-supply property specifies the supply powering the panel as a phandle 
> to a regulator.

That works for me. Do you want me to resend it with that text, or
should I merge it (and if so, with your Reviewed-by or Acked-by?)?

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/ddaee006/attachment-0001.sig>
