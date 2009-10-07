From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2009 09:12:35 +0100
Subject: ucb1x00 patches
In-Reply-To: <200910070956.42651.marek.vasut@gmail.com>
References: <4ACB7123.8000609@gmx.de> <19148.16274.293527.828860@ipc1.ka-ro>
	<200910070956.42651.marek.vasut@gmail.com>
Message-ID: <20091007081235.GA6246@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2009 at 09:56:42AM +0200, Marek Vasut wrote:
> Dne St 7. ??jna 2009 09:13:22 Lothar Wa?mann napsal(a):
> > Hi,
> > 
> > Thomas Kunze writes:
> > > Hi,
> > >
> > > I posted these patches at linux-arm-kernel as part of the patchset
> > > "collie and SA1100 patches".
> > > Could you please comment on them? I'd also like to know you opinion on
> > > moving ucb1x00-ts.c to
> > > input/drivers/touchscreen.
> > 
> > What about the ucb1400_ts.c which is already there?
> > 
> 
> I'd be for unifying all the ucb drivers into a single one, but Russell was 
> against it iirc.

They're different beasts, and I really don't think they should be unified.
They have different register layouts, and different access arrangements,
which need different handling.

The result is that the UCB1200/UCB1300 support gets unnecessarily penalised
when UCB1400 is integrated - instead of merely taking a spinlock and
accessing the register, you have to ensure everything you do is in thread
context, including interrupt handlers.
