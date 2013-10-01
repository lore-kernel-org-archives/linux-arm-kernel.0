From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 1 Oct 2013 10:42:14 -0300
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet ge0
 and ge1 clocks
In-Reply-To: <20131001004009.GK31178@titan.lakedaemon.net>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
Message-ID: <20131001134213.GC2448@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 08:40:09PM -0400, Jason Cooper wrote:
> On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
> > These clocks should never be gated, since the ethernet interfaces forget
> > the assigned MAC address assigned if their clock source is turned off.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> > Cc: Mike Turquette <mturquette@linaro.org>
> > 
> >  drivers/clk/mvebu/kirkwood.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> I'm inclined to leave this as a hack in board-dt.c...  At some point we
> are going to move kirkwood over to mach-mvebu/, and there will be eyes
> on the code.  There's less chance of 're-discovering' this for cleanup
> if it's in the clock driver, looking all proper and such.  Even with the
> clear comment.
> 

Hm.. Really? I honestly think this change is a far cleaner way of
dealing with the problem.

The motivation for these 4 patches, came from an attempt of booting a
multiplatform kernel Kirkwood, which _almost_ booted fine :P

So, I see this as preparation work for the move to mach-mvebu.

Does anybody have any insights on how a proper fix would be done
in the net driver?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
