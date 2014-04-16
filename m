From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Apr 2014 18:19:38 +0200
Subject: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
In-Reply-To: <20140416160824.GA14842@lunn.ch>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com> <20140416180315.5153c3f7@skate>
 <20140416160824.GA14842@lunn.ch>
Message-ID: <20140416181938.6e8f8f4b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 16 Apr 2014 18:08:24 +0200, Andrew Lunn wrote:
> > For minor differences such as SoC stepping, I personally prefer to not
> > have separate Device Trees. We already have many of them, for each
> > variant of the various SOCs. If we add the different steppings, it's
> > going to be even more complicated. Also, there will be a new iteration
> > of the Armada 375 DB with an A0 chip, which does not have the Z1 bug.
> 
> How many Z1 are there out and about? Would it be simpler to just
> disable thermal on Z1? If only development boards have Z1, this could
> be reasonable.

Not many, but we also need workarounds for other Z1 issues, such as the
I/O coherency workaround (see the 375 coherency patches) and the SMP
issue (see the 375 SMP patches).

For now, Gregory, Ezequiel and myself only have access to Z1 boards, so
we would like to support this stepping at least until all of us have
access to A0 boards. If we don't do this, then we need to keep an ugly
pile of out-of-tree patches just to get our boards running, which is
clearly not the best way of ensuring that mainline has all the
necessary fixes.

So, I would like to see the Z1 stepping supported for now, and have the
freedom to remove its support later once we are all ready to switch to
A0.

For 375 and 38x, we have the chance of having started the mainlining
process very early compared to the life cycle of the SoC, and part of
the consequences of this chance is that we work on early steppings. It
would seem weird for the kernel community to ask silicon vendors to
mainline their code earlier, and at the same time refuse workarounds
needed to bring up early SoC variants.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
