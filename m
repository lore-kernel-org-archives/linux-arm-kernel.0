From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 20:55:41 +0200
Subject: [PATCH 0/2] mtd: nand: sunxi: cleanup
In-Reply-To: <20150930181135.GF143959@google.com>
References: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150929222144.GA143959@google.com>
 <20150930083634.68351ade@bbrezillon>
 <20150930181135.GF143959@google.com>
Message-ID: <20150930205541.59d6e981@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Wed, 30 Sep 2015 11:11:35 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Wed, Sep 30, 2015 at 08:36:34AM +0200, Boris Brezillon wrote:
> > On Tue, 29 Sep 2015 15:21:44 -0700
> > Brian Norris <computersforpeace@gmail.com> wrote:
> > 
> > > On Wed, Sep 16, 2015 at 09:46:35AM +0200, Boris Brezillon wrote:
> > > > Hello,
> > > > 
> > > > Those two patches aim at cleaning up the sunxi_nand driver by first adding
> > > > some consistency in the macro definitions, and then factorizing the code
> > > > duplicated code found in hw_ecc and hw_syndrome_ecc implementations.
> > > > 
> > > > Best Regards,
> > > > 
> > > > Boris
> > > 
> > > I believe this series no longer applies cleanly
> > 
> > Hm, actually it depends on fixes you have in your linux-mtd tree and
> > features in your l2-mtd tree.
> > 
> > I don't know how you usually deal with those problems (merging the
> > linux-mtd/master branch into the l2-mtd/master one, or merging
> > last linus' -rc into l2-mtd/master should work), but I'd really
> > like to have this in 4.4 :-).
> 
> linux-mtd.git is prepped for a pull request. I'll do that before the
> week ends. And I'll either merge that back into l2-mtd.git at that time,
> or just pull in v4.3-rc4.

Perfect.

> 
> > I still have the patch using the nand_check_erased_ecc_chunk() function
> > which depends on those 2 patches, and I'd like to have it in 4.4 too.
> > 
> > I know I'm asking a lot, but as explained earlier, I still have a
> > bunch of patches on top of those already posted (mainly to support
> > the hardware randomizer), and I'd like the trivial ones to be merged
> > quickly.
> 
> I'll see what I can apply after pulling together all the latest, but if
> I'm still missing things then, feel free to resend.

Apparently I have a few things to rework in patch 2, so I'll resend
it ;-).

> 
> BTW, I thought there were some things to address on the erased ECC stuff
> still. I'll re-check that series too.

AFAIR, I had a few things to fix, and we were waiting for some feedback.
I also told you I would test the series on an atmel platform (which I
haven't done yet :-/).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
