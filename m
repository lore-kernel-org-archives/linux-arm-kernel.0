From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 12:19:13 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120822081746.GA4089@gmail.com>
References: <20120820162923.GF26991@opensource.wolfsonmicro.com>
 <20120820164949.GB22749@gmail.com>
 <20120820175155.GH26991@opensource.wolfsonmicro.com>
 <20120821085618.GA26899@gmail.com>
 <20120821095026.GU26991@opensource.wolfsonmicro.com>
 <20120821105413.GD26899@gmail.com>
 <20120821110329.GA7995@opensource.wolfsonmicro.com>
 <20120821120243.GF26899@gmail.com>
 <20120821165207.GX7995@opensource.wolfsonmicro.com>
 <20120822081746.GA4089@gmail.com>
Message-ID: <20120822111913.GG7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 09:17:50AM +0100, Lee Jones wrote:

> I was saying that in order for the MFD core to carry out the hwirq->virq
> conversion, it needed to obtain the irqdomain pointer pertaining to the
> provided hwirq. The only helper function the irqdomain subsystem provides
> requires a device node pointer to be passed as an argument, hence the
> mention of 'irq_find_host(struct device_node *np)'. Then the Device Tree
> is traversed until a specified 'interrupt-controller' is stumbled upon
> or is pointed to by the 'interrupt-parent' property. Hence, we have to 
> find another way to find the irqdomain pointers for non-DT based MFDs. To
> which we now have a solution.

Oh, right.  Yes, there's no way to get an irqdomain if you don't already
have it or something which has a direct mapping to one like an irqdomain.

> > I made the suggestion then later on realised that this was actively
> > going to break things I care about so I actually need it fixing.

> I'm a little taken aback and annoyed by this. In a previous email thread
> you categorically requested that I discuss some of the important changes
> with maintainers and people in-the-know prior to actually writing any
> code.

No, that's not something I've ever said to do.

I *have* asked you to communicate more clearly about what you're doing
but that doesn't mean to stop sending code, it means to have clearer
words around what you're sending.  The really bad pattern here is that
you're frequently working around issues in your drivers with changes in
the subsystem without mentioning that the driver issues even exist -
this makes it much harder understand what you are trying to achieve,
especially when there is a problem with your subsystem changes and/or
the urgency you're attaching to them.

>       I was obviously actively working on, had put time into, and was in
> the mist of discussing this with you. Then you just go ahead and code it
> (the easy part) yourself, essentially wasting my time. Surely there's
> some kind of etiquette surrounding such things?

To be honest in this case I had expected to send the patch out much
sooner than I did - several priority interrupts stopped me testing it.
Like I say I realised that I really needed a fix and it seemed like the
quickest way to accomplish that was to just send the code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/7e96b246/attachment.sig>
