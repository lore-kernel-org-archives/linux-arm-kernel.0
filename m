From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jan 2013 13:31:40 +0000
Subject: [PATCHv2 00/19] ARM: common warning fixes
In-Reply-To: <20130126100542.GC23505@n2100.arm.linux.org.uk>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
 <20130126100542.GC23505@n2100.arm.linux.org.uk>
Message-ID: <201301261331.40932.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 January 2013, Russell King - ARM Linux wrote:
> On Fri, Jan 25, 2013 at 10:43:59PM +0000, Arnd Bergmann wrote:
> > I will get to those once this series is sorted out.
> > Since there are no interdepencies between the patches,
> > my preference is to have them applied by the individual
> > subsystem maintainers. Anything that has not at
> > least made it into linux-next by the next merge window
> > and has not received a 'NAK' or been obsoleted by
> > another patch, I plan to submit as part of an arm-soc
> > branch for 3.9.
> 
> And, last night we have new warnings.  My allnoconfigs no longer build
> cleanly because of new vexpress section mismatches in the mfd code.

Yes, I already sent a patch yesterday. The problem was a regression
that came in through the arm-soc tree unfortunately, but I can easily
fix it then.

> It seems to me that you're on a loosing battle unless you test the tree
> and drop code before propaging it out if it adds new warnings... force
> the pain of these warnings down on to others so that they learn to create
> better code in the first place.

That was always the idea, right now I mainly try to get back to the almost
clean state I had some time ago.

The largest problem right now is gcc-4.7, which adds a lot of new bogus
warnings.

	Arnd
