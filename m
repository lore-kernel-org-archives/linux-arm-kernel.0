From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2016 22:19:18 +0200
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <20160906194443.GC1041@n2100.armlinux.org.uk>
References: <20160906140808.2883875-1-arnd@arndb.de>
 <6239709.hYdxF7WW9G@wuerfel> <20160906194443.GC1041@n2100.armlinux.org.uk>
Message-ID: <4510913.a46LvNLeqZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 8:44:43 PM CEST Russell King - ARM Linux wrote:
> On Tue, Sep 06, 2016 at 09:28:17PM +0200, Arnd Bergmann wrote:
> > On Tuesday, September 6, 2016 3:24:42 PM CEST Russell King - ARM Linux wrote:
> > > On Tue, Sep 06, 2016 at 04:07:56PM +0200, Arnd Bergmann wrote:
> > I'm experimenting with cleaning up the file some more, but it's unclear
> > if doing it another way is an actual improvement, or if a larger change
> > is worth the risk for regressions, given how little interest there is
> > in this platform in general.
> 
> If there's little interest in it, and little stomach to fix it, maybe
> the better thing is to remove it if no one has an interest in it?
> 
> > [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-September/003803.html
> 
> What Linus has failed to understand is that the reason why we've kept
> NO_IRQ as -1 is that changing NO_IRQ to 0 results in regressions - I've
> been through as much as the code that I'm personally happy to convert
> each time this has come up, and what remains has been the stuff that
> I've not been happy to touch through fear of breaking it.

Out of the 20 patches os so that I did for the complete removal on ARM,
a clear majority was fixing code that is already broken (usually in
error handling code paths that are never exercised in practice though).

> So, changing NO_IRQ to 0 results in regressions.  Trying to fix the
> sites probably results in regressions too (I've already seen one
> example with your UCB1x00 patch of such breakage caused by mindless
> "conversion".)

The patch was correct, the only problem that you pointed out already
was that it needs to be applied on top of your patch. I didn't
check when the file was touched the last time but only looked at
the current state in linux-next that happened to be from your
patch last week.

	Arnd
