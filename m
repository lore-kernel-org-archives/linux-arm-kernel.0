From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Mar 2011 08:38:44 +0000
Subject: [PATCHv2 1/9] at91: provide macb clks with "pclk" and "hclk" name
In-Reply-To: <AANLkTimwwUQGhncE7Att_9rAXhpT0n61HC4SW8ShSfAm@mail.gmail.com>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-2-git-send-email-jamie@jamieiles.com>
	<AANLkTimwwUQGhncE7Att_9rAXhpT0n61HC4SW8ShSfAm@mail.gmail.com>
Message-ID: <20110316083844.GA13262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 08:53:47AM +0200, avictor.za at gmail.com wrote:
> hi,
> 
> On Tue, Mar 15, 2011 at 12:14 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > The macb driver expects clocks with the names "pclk" and "hclk". ?We
> > currently provide "macb_clk" but to fit in line with other
> > architectures (namely AVR32), provide "pclk" and a fake "hclk".
> 
> There is no reference to a "pclk" or "hclk" in the AT91 architecture.
> So to avoid possible confusion, maybe create two "fake" clocks both
> parented to "macb_clk", and add a comment they're only for
> compatibility with the AVR32.

It doesn't matter what's in the documentation.

There's no apb_pclk mentioned in the ARM platform documentation yet we
have such a clock in the bus-level code for primecell support.  I'm sure
many of the other early primecell using platforms are also the same.

On OMAP1 there's no iclk yet OMAP drivers have had iclk and iclk is a
dummy no-op clock for OMAP1 for compatibility with OMAP2.

What matters more than conforming to documentation is keeping the drivers
in a clean and maintainable state without throwing lots of ifdefs into
them.
