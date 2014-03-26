From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 26 Mar 2014 11:48:05 -0300
Subject: [PATCH v2 0/3] mv_xor: Spinlock cleanup
In-Reply-To: <20140313191259.GB21811@arch.cereza>
References: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140313191259.GB21811@arch.cereza>
Message-ID: <20140326144805.GA18322@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 13, Ezequiel Garcia wrote:
> On Mar 07, Ezequiel Garcia wrote:
> > Vinod, Dan,
> > 
> > This series is v2 of the one previously sent by Thomas Petazzoni [1].
> > I've tried to address the comments made by Andi and Dan, and also kept
> > Thomas' ultimate goal: get rid of the mv_xor_slot_cleanup() function
> > (which takes the spinlock).
> > 
> > The first patch removes the unneeded call to mv_xor_clean_completed_slots(),
> > in mv_xor_as explained by Dan [2].
> > 
> > The other two patches replace the calls to mv_xor_slot_cleanup() with
> > calls to __mv_xor_slot_cleanup(). This allows to have the same "spinlock held"
> > requirement on all callers.
> > 
> > The patchset is based on v3.14-rc5 and has been tested on an Armada XP GP board.
> > 
> > [1] http://www.spinics.net/lists/arm-kernel/msg297176.html
> > [2] http://www.spinics.net/lists/arm-kernel/msg297518.html
> > 
> > Ezequiel Garcia (3):
> >   dma: mv_xor: Remove unneeded mv_xor_clean_completed_slots() call
> >   dma: mv_xor: Remove all callers of mv_xor_slot_cleanup()
> >   dma: mv_xor: Rename __mv_xor_slot_cleanup() to mv_xor_slot_cleanup()
> > 
> >  drivers/dma/mv_xor.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> > 
> 
> Ping?
> 

Ping^2 ?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
