From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Mar 2011 15:10:11 +0100
Subject: How to handle kprobe bugs?
In-Reply-To: <1301493213.2488.41.camel@computer2.home>
References: <1301493213.2488.41.camel@computer2.home>
Message-ID: <20110330141011.GA2844@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 02:53:33PM +0100, Tixy wrote:
> Now that I'm writing some test code for kprobes I'm quickly finding
> further bugs with the instruction emulation. E.g. ALU ops with an
> immediate operand are broke. Shall I wait until I have completed writing

Good spot ... if so, this definitely needs fixing(!)

> all test cases before submitting a single fix patch? (It could be a
> couple of weeks.)

My view (others may differ):

If there are several independent fixes, that's probably best presented
as multiple patches; but it may be better to post them as a series when
you're done.

I expect this will be more digestible for people than a trickle of
patches over a longer period, unless the total changeset becomes
large.

> 
> I also find that instruction emulation for some (all?) ARMv6K and newer
> instructions are missing. E.g. hint instructions like NOP and WFI. Shall
> I produce a second patch to add these?

Sure.

Note that you should emulate all the hinted NOPs as actual NOPs,
since the event the hint waits for may happen in the meantime;
under some circumstances that would lead to stalls.

> 
> At some point I will also get around to doing my original task of adding
> Thumb support to kprobes. I'm assuming that fixing ARM code is higher
> priority than adding Thumb support?

I think that's reasonable, provided there is not too much work to do
to fix the ARM case -- it sounds like there isn't much to fix, but
please shout otherwise.

Cheers
---Dave
