From: ralph@inputplus.co.uk (Ralph Corderoy)
Date: Wed, 31 Mar 2010 01:06:57 +0100
Subject: [E3-hacking] [RFC][PATCH v2 1/5] omap1: Amstrad Delta: add FIQ
	handler for serial keyboard port interrupt processing
In-Reply-To: <201003301708.41634.jkrzyszt@tis.icnet.pl> 
References: <201003291619.25878.jkrzyszt@tis.icnet.pl>
	<201003291624.10034.jkrzyszt@tis.icnet.pl>
	<20100329183211.F105C493B@blake.inputplus.co.uk>
	<201003301708.41634.jkrzyszt@tis.icnet.pl>
Message-ID: <20100331000657.D97895225@blake.inputplus.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Janusz,

> And thanks for pushing me into reading the ARM Assembly Language book,
> so I would be able to do more than just understanding and copy-pasting
> the code ;).

It's a lovely instruction set compared to many others.

> > > +state:
> > > +	ldr r10, [r9,#FIQ_STATE]
> > > +	cmp r10, #0				@ are we expecting start bit?
> > > +	bne data				@ no - in data processing state
> >
> > Similarly, an `ldrs' here would make the cmp redundant.
> 
> I'm not sure if the S suffix is also valid for memory transfer
> instructions

No, you're correct.  Memory transfers can't do the "set ALU flags"
S-bit.  Sorry to mislead.

Cheers,
Ralph.
