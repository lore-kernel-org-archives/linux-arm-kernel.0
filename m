From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Oct 2009 14:08:49 +0100
Subject: ucb1x00 patches
In-Reply-To: <20091011121458.GA1356@ucw.cz>
References: <4ACB7123.8000609@gmx.de> <19148.16274.293527.828860@ipc1.ka-ro>
	<200910070956.42651.marek.vasut@gmail.com>
	<20091007081235.GA6246@n2100.arm.linux.org.uk>
	<20091011121458.GA1356@ucw.cz>
Message-ID: <20091012130849.GA1476@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 11, 2009 at 02:14:58PM +0200, Pavel Machek wrote:
> On Wed 2009-10-07 09:12:35, Russell King - ARM Linux wrote:
> > On Wed, Oct 07, 2009 at 09:56:42AM +0200, Marek Vasut wrote:
> > > Dne St 7. ????jna 2009 09:13:22 Lothar Wa??mann napsal(a):
> > > > Hi,
> > > > 
> > > > Thomas Kunze writes:
> > > > > Hi,
> > > > >
> > > > > I posted these patches at linux-arm-kernel as part of the patchset
> > > > > "collie and SA1100 patches".
> > > > > Could you please comment on them? I'd also like to know you opinion on
> > > > > moving ucb1x00-ts.c to
> > > > > input/drivers/touchscreen.
> > > > 
> > > > What about the ucb1400_ts.c which is already there?
> > > > 
> > > 
> > > I'd be for unifying all the ucb drivers into a single one, but Russell was 
> > > against it iirc.
> > 
> > They're different beasts, and I really don't think they should be unified.
> > They have different register layouts, and different access arrangements,
> > which need different handling.
> > 
> > The result is that the UCB1200/UCB1300 support gets unnecessarily penalised
> > when UCB1400 is integrated - instead of merely taking a spinlock and
> > accessing the register, you have to ensure everything you do is in thread
> > context, including interrupt handlers.
> 
> Is it that bad?
> 
> If sharing makes sense on source-code level, that kind of penalty
> should be acceptable. If it makes more eyes on the sources, it will
> still be a win.

That argument doesn't always apply.  It is only a win if you have lots
of people testing the code out on *both* chips, so that bugs are
discovered quickly.

The UCB1200/1300 support is stable and good.  Don't break it by totally
changing the way it works just for the sake of a wooley "more eyes must
be good" flimsy argument.
