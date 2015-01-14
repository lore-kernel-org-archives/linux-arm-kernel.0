From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Jan 2015 14:33:32 -0500
Subject: [PATCH v2 2/5] irqchip: Add DT binding doc for dumb demuxer chips
In-Reply-To: <20150114200809.0c16baae@bbrezillon>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-3-git-send-email-boris.brezillon@free-electrons.com>
 <20150113190050.GZ24989@titan.lakedaemon.net>
 <20150113215207.185d92b4@bbrezillon>
 <20150114185619.GB24989@titan.lakedaemon.net>
 <20150114200809.0c16baae@bbrezillon>
Message-ID: <20150114193332.GC24989@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 08:08:09PM +0100, Boris Brezillon wrote:
> Hi Jason,
> 
> On Wed, 14 Jan 2015 13:56:19 -0500
> Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > Hey Boris,
> > 
> > On Tue, Jan 13, 2015 at 09:52:07PM +0100, Boris Brezillon wrote:
> > > On Tue, 13 Jan 2015 14:00:50 -0500 Jason Cooper <jason@lakedaemon.net> wrote:
> > > > On Tue, Jan 13, 2015 at 07:46:18PM +0100, Boris Brezillon wrote:
> > > > > Add documentation for the dumb demuxer.
> > > > > 
> > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > > ---
> > > > >  .../bindings/interrupt-controller/dumb-demux.txt   | 34 ++++++++++++++++++++++
> > > > >  1 file changed, 34 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > new file mode 100644
> > > > > index 0000000..1c777ef
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > @@ -0,0 +1,34 @@
> > > > > +* Generic Dumb Interrupt Demultiplexer
> > > > > +
> > > > > +This Dumb demultiplixer simply forward all incoming interrupts to its
> > > > > +enabled/unmasked children.
> > > > 
> > > > Please forgive the potentially na?ve question, but what hardware is this
> > > > describing?
> > > 
> > > That's not a real hardware per se, but on some hardware (like at91 SoCs)
> > > some IRQ line are shared by several peripherals, and this dumb
> > > demultiplex is here to represent such shared irq lines which cannot be
> > > easily demultiplexed (because they do not provide a 'cause'
> > > register).
> > > 
> > > You can see it as a virtual irqchip provided to address broken hardware
> > > designs.
> > 
> > Hmm.  Well, given tglx's recent reply, I suppose I'll *not* go down the
> > rabbit hole of "the DT is for describing hardware."  :-P
> 
> Actually I'm a bit surprised no one else already mentioned that :-) (I
> thought this would be the first complain regarding this dumb irq
> demux chip).
> 
> Anyway, IMHO, this can be considered as hardware description since
> these irq-lines are really multiplexed into a single one...

True, I think the issue is more that the DT node doesn't strictly
represent a block of IP.  We just need a way to make that clear in the
binding doc.

> > However, it would probably be a lot more palatable to the DT maintainers
> > if we at least change the compatible to prepend "linux,".  This way, if
> > someone does come up with a better solution down the road, it will be
> > much easier to deprecate the binding.
> > 
> > I would also be amenable to "virt,", or "hack,", or even
> > "work-around-piss-poor-hw,".  Basically, anything that would indicate to
> > consumers of the DT that this is not a true reflection of the hardware,
> > and that it may be superseded by a better solution later.
> 
> Actually I thought about changing it to "virtual,dumb-irq-demux" :-).

Works for me. :)

thx,

Jason.
