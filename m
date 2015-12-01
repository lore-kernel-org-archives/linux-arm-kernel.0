From: carlo@caione.org (Carlo Caione)
Date: Tue, 1 Dec 2015 17:02:21 +0100
Subject: [linux-meson] Re: [PATCH v2 4/5] pinctrl: dt-binding: Extend
 meson documentation with GPIO IRQs support
In-Reply-To: <20151123234720.GA879@rob-hp-laptop>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
 <1448273816-11290-5-git-send-email-carlo@caione.org>
 <20151123234720.GA879@rob-hp-laptop>
Message-ID: <20151201160221.GA28755@caronte>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, nov 23, 2015 at 05:47:20 -0600, Rob Herring wrote:
> On Mon, Nov 23, 2015 at 11:16:55AM +0100, Carlo Caione wrote:
> > From: Carlo Caione <carlo@endlessm.com>
> > 
> > Extend the pinctrl binding documentation with the support for external
> > GPIO interrupts.
> > 
> > Signed-off-by: Carlo Caione <carlo@endlessm.com>
> > Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> > index 3f6a524..56743eb 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> > +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> > @@ -3,6 +3,12 @@
> >  Required properties for the root node:
> >   - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
> >   - reg: address and size of registers controlling irq functionality
> > + - reg-names: should be "irq"
> 
> You don't really need names when there is only one. Otherwise:
> 
> Acked-by: Rob Herring <robh@kernel.org>

I missed this reply sorry. The name is conveniently used so that I can
use the meson_map_resource() helper function to map that and get back
the regmap struct in one shot.

I'm going to submit v3 soon without this modification leaving out your
Acked-by. Let me know if your ACK is still valid without this code
change.

-- 
Carlo Caione
