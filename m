From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 12:03:29 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120821105413.GD26899@gmail.com>
References: <CACRpkdYbOBEPNbCdfi+=gupdqS8_7t7MpOgXs7VCVTs8Y3j_mQ@mail.gmail.com>
 <20120820083640.GH8450@gmail.com>
 <20120820121055.GA26991@opensource.wolfsonmicro.com>
 <20120820125531.GA20242@gmail.com>
 <20120820162923.GF26991@opensource.wolfsonmicro.com>
 <20120820164949.GB22749@gmail.com>
 <20120820175155.GH26991@opensource.wolfsonmicro.com>
 <20120821085618.GA26899@gmail.com>
 <20120821095026.GU26991@opensource.wolfsonmicro.com>
 <20120821105413.GD26899@gmail.com>
Message-ID: <20120821110329.GA7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 11:54:14AM +0100, Lee Jones wrote:
> On Tue, Aug 21, 2012 at 10:50:27AM +0100, Mark Brown wrote:

> > What makes you say this?  This is just a convenience for finding a
> > domain, irqdomains are *completely* indepentant of device tree.

> How can you say that? I think you mean _can_ be independent of DT. If
> that's what you mean then yes, that's true. All I'm saying is we need

No, I really mean what I'm saying.  Device tree builds on irqdomains,
not the other way around.

> another way to get hold of the domain, because the only way to obtain
> it without having direct access is via a device node.

This doesn't actually hold.

> > > - I know that you have interest in pushing the functionality into the
> > > IRQ domain subsystem, but I'm struggling to see how. It's calling into
> > > the IRQ domain where we're seeing issues in the first place, specifically
> > > irq_create_mapping(). How about if we passed 'irq_domain' as a parameter
> > > when requesting the IRQ? That way we can pass the correct IRQ without
> > > worry of conversion. If 'irq_domain' is !NULL the IRQ management subsystem
> > > can do the necessary conversions. If 'irq_domain' is NULL it continues to
> > > use the requested IRQ as a virq.

> > This is totally orthogonal to doing the mapping in the MFD subsystem
> > which is the issue here.

> Again, I only mentioned this because you said you wanted it to be handled
> by the irqdomain.

The *mapping* should be being handled in irqdomain.

> I'll code up the second suggestion now.

I've already done this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/ba3c2e95/attachment.sig>
