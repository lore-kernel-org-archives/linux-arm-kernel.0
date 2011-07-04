From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 13:33:01 +0100
Subject: [RFC PATCH 0/3] base board consolidation
In-Reply-To: <201107041355.52025.marek.vasut@gmail.com>
References: <20110701094403.GT11559@pengutronix.de>
	<CACTFLAPsaiF8KEXeDGOX72dcAvzegHDUQcPEPNxywwYewrHsUw@mail.gmail.com>
	<20110704103820.GC8286@n2100.arm.linux.org.uk>
	<201107041355.52025.marek.vasut@gmail.com>
Message-ID: <20110704123301.GE8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 01:55:51PM +0200, Marek Vasut wrote:
> Which leads me to a question (likely quite off-topic here). Working on a pxa-
> device tree support, there're a lot of procedures called during init doing 
> exactly this -- how do you handle this via device tree ? Is there any way to 
> call them ? Or does the kernel need to patch device tree on run-time ? Or how?

That is _precisely_ my concern which caused me to be unconvinced that
DT actually solves the problem which Linus is concerned about.

What I see is that DT solves part of the problem, but we're still going
to end up having board files to deal with procedural stuff which can't
be encoded in DT.

That in turn leads to the problem of how to bind the board specific code
in board files into DT declared devices (that information will likely be
Linux specific and may not be stable between kernel versions, so would
probably require kernel version specific DTs).

I think others (eg Nico) share that view.

If that is how things will turn out, then we've got a far bigger problem
to deal with than that which we started with - and at that point it may
be far easier maintainability wise to fork the kernel from the pre-DT
stage and continue as we have been.

The only reason that I've said yes to DT is through pressure from multiple
directions (including Linus), and I'm willing to see whether it _can_ work.
However, I remain entirely unconvinced, even at this stage.

If it was up to me, then I'd still have DT out of the kernel tree, pending
some real platforms with the issue you raised having been converted to it
so we can see how these problems are addressed.
