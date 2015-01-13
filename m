From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 13 Jan 2015 21:52:07 +0100
Subject: [PATCH v2 2/5] irqchip: Add DT binding doc for dumb demuxer chips
In-Reply-To: <20150113190050.GZ24989@titan.lakedaemon.net>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-3-git-send-email-boris.brezillon@free-electrons.com>
 <20150113190050.GZ24989@titan.lakedaemon.net>
Message-ID: <20150113215207.185d92b4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, 13 Jan 2015 14:00:50 -0500
Jason Cooper <jason@lakedaemon.net> wrote:

> Boris,
> 
> On Tue, Jan 13, 2015 at 07:46:18PM +0100, Boris Brezillon wrote:
> > Add documentation for the dumb demuxer.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  .../bindings/interrupt-controller/dumb-demux.txt   | 34 ++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > new file mode 100644
> > index 0000000..1c777ef
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > @@ -0,0 +1,34 @@
> > +* Generic Dumb Interrupt Demultiplexer
> > +
> > +This Dumb demultiplixer simply forward all incoming interrupts to its
> > +enabled/unmasked children.
> 
> Please forgive the potentially na?ve question, but what hardware is this
> describing?

That's not a real hardware per se, but on some hardware (like at91 SoCs)
some IRQ line are shared by several peripherals, and this dumb
demultiplex is here to represent such shared irq lines which cannot be
easily demultiplexed (because they do not provide a 'cause'
register).

You can see it as a virtual irqchip provided to address broken hardware
designs.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
