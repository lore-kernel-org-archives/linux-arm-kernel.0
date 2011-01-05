From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 5 Jan 2011 17:15:04 +0100
Subject: mmci: U300 "sync with blockend" broken for multi-block?
In-Reply-To: <20110101121048.GB25924@n2100.arm.linux.org.uk>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
	<20110101121048.GB25924@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> It would be good to characterize what's actually going on with U300 some
> more, especially the timing between these signals and the FIFO interrupts,
> rather than just stating that they occur "out of order".

I will try to document more closely. OTOMH it was like
for reads they would come in one order first one then
another and for writes the other way around. That was
why the older quirk for U300 was working, wiring the
DATAEND high, though it was no good in modeling
what was actually happening.

> Is the data block end interrupt being triggered when you've read the
> required data from the FIFO, and the data end interrupt triggered when
> the card has transferred the required amount of data (iow, data into
> the FIFO)?
>
> Once they have been properly characterized, then it may be possible to
> come up with an alternative solution. ?At the moment, it's very had to
> guess what's going on from the descriptions given.

Ulf, do you know the details of what is happening here?
I think you have the most up-to-date knowledge.

I've been trying to determine this a number of times,
empirically mostly, probably failing to understand the
most important variables. The current solution is as
far as I've been able to model what's actually happening.

Yours,
Linus Walleij
