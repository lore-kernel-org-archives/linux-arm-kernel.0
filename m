From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 May 2015 11:01:02 +0200
Subject: [PATCH 2/3] Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA
 don't overlap the MBus bridge window"
In-Reply-To: <2099675.EoA8CYtzXr@wuerfel>
References: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1432802414-12355-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <2099675.EoA8CYtzXr@wuerfel>
Message-ID: <20150528110102.10cb2e85@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Thu, 28 May 2015 10:49:46 +0200, Arnd Bergmann wrote:
> On Thursday 28 May 2015 10:40:13 Thomas Petazzoni wrote:
> > Fixes: 1737cac69369 ("bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window")
> > Cc: <stable@vger.kernel.org> # v4.0+
> > ---
> >  drivers/bus/mvebu-mbus.c | 105 ++++++++---------------------------------------
> >  1 file changed, 16 insertions(+), 89 deletions(-)
> 
> Hmm, the stable kernel rules say that a patch cannot exceed 100
> lines with context, so this one is technically too large.

Ah, okay, I didn't know about this specific rule.

> Maybe Greg has a suggestion about what to do here. Is it possible
> to make an exception for a revert? In theory you could make a
> smaller version of the patch that adds an #if 0 instead of removing
> some of the code that was added, in order to get below the limit,
> but that seems counterproductive for minimizing the possible risk.

In the specific case of such an exact revert, isn't it possible to make
an exception? I guess the very reason we have rules is to have
exceptions for such rules, no? :-)

It would really be more logical to have a revert than a different patch
just disabling the change, since it would actually be more risky than
just reverting to the previous situation.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
