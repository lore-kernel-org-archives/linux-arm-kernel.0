From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 25 Oct 2013 20:11:55 +0100
Subject: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <20131025075639.75f45fb0@ipc1.ka-ro>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
 <20131024164746.3CB36C403B6@trevor.secretlab.ca>
 <20131025075639.75f45fb0@ipc1.ka-ro>
Message-ID: <20131025191155.2D7D7C40429@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Oct 2013 07:56:39 +0200, Lothar Wa??mann <LW@KARO-electronics.de> wrote:
> Hi,
> 
> Grant Likely wrote:
> > On Thu, 24 Oct 2013 14:42:13 +0200, Denis Carikli <denis@eukrea.com> wrote:
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > Cc: Pawel Moll <pawel.moll@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > > Cc: devicetree at vger.kernel.org
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input at vger.kernel.org
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: Lothar Wa????mann <LW@KARO-electronics.de>
> > > Cc: Eric B????nard <eric@eukrea.com>
> > > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > ---
> > > ChangeLog v6->v7:
> > > - One small whitespace cleanup.
> > > - The properties specific to that driver are now prefixed with "ti,".
> > > - The ti,fuzzy property has now better documentation.
> > > ---
> > >  .../bindings/input/touchscreen/tsc2007.txt         |   45 +++++
> > >  drivers/input/touchscreen/tsc2007.c                |  194 +++++++++++++++-----
> > >  2 files changed, 198 insertions(+), 41 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > new file mode 100644
> > > index 0000000..516b63b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > @@ -0,0 +1,45 @@
> > > +* Texas Instruments tsc2007 touchscreen controller
> > > +
> > > +Required properties:
> > > +- compatible: must be "ti,tsc2007".
> > > +- reg: I2C address of the chip.
> > > +- ti,x-plate-ohms: X-plate resistance in ohms.
> > > +
> > > +Optional properties:
> > > +- gpios: the interrupt gpio the chip is connected to (trough the penirq pin)
> > > +  (see GPIO binding[2] for more details).
> > 
> > Hmmm, why is this needed? Is the line used for anything other than
> > finding the irq number? If it is just an interrupt then an interrupts
> > property is all that should be specified.
> > 
> It's also the pendown detect GPIO. It asserts an interrupt when first
> activated and is then polled in the driver until it goes inactive again.

That should definitely be in the document then. Otherwise the binding
looks okay to me.

g.
