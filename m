From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Oct 2016 11:40:44 +0200
Subject: [PATCH v2 2/9] dt-bindings: interrupt-controller: add DT
 binding for meson GPIO interrupt controller
In-Reply-To: <20161027093205.GA27135@leverpostej>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
 <1476890480-8884-3-git-send-email-jbrunet@baylibre.com>
 <20161026214234.4q6wmecehqh6q32o@rob-hp-laptop>
 <20161027093205.GA27135@leverpostej>
Message-ID: <1477561244.2482.198.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-10-27 at 10:32 +0100, Mark Rutland wrote:
> On Wed, Oct 26, 2016 at 04:42:35PM -0500, Rob Herring wrote:
> > 
> > On Wed, Oct 19, 2016 at 05:21:13PM +0200, Jerome Brunet wrote:
> > > 
> > > 
> > > This commit adds the device tree bindings description for
> > > Amlogic's GPIO
> > > interrupt controller available on the meson8, meson8b and gxbb
> > > SoC families
> > > 
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > ---
> > > Rob, I did not include the Ack you gave for the RFC as bindings
> > > have slightly
> > > changed. Only the interrupt property has be removed following a
> > > discussion I
> > > had with Marc
> > 
> > As Mark R already said, you should keep the interrupts property.
> 
> To be clear, the interrupt routing should be described *somehow*,
> though
> I don't think the generic interrupts property is correct, as this is
> an
> interrupt *router*, i.e. this device doesn't own the interrupt, it
> just
> joins two parts of the line together (and so flags are meaningless).
> 
> Thanks,
> Mark.

Indeed Mark,

I already rewritten the driver taking Marc's comment into account.
There will be 2 properties added to the DT:
?-?meson,upstream-interrupts : an array with the 8 gic interrupt used
as output of the controller
- ?meson,num-input-mux : the number of inputs (pads) available to the
muxes

I'm looking for solution to the "create mapping" issue we have in
pinctrl (patch 4) before posting a v3.

If you think these properties should be different, feel free to tell me
now.

Thx
Jerome
