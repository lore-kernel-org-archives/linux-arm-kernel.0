From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 19:00:04 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522164928.GD27348@1wt.eu>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164928.GD27348@1wt.eu>
Message-ID: <20130522190004.67880320@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Wed, 22 May 2013 18:49:28 +0200, Willy Tarreau wrote:

> > I guess the Mirabox and OpenBlocks have been shipping for about 9-10
> > months now. Judging by the amount of e-mails are received about Mirabox
> > kernel (asking when PCIe support will be available, when NAND will be
> > available), there is definitely a certain number of people who have
> > those platforms in their hands.
> 
> Indeed, but either these people are running stock kernel on them and don't
> care, or they're ready to hack their box and should not be much frightened
> by a boot loader upgrade (especially since it's safe from the UART as we
> have found).

Yes, they could upgrade. But as of today, such upgrades do not even
exist for the Mirabox and OpenBlocks AX3 boards. So what do we tell to
those users?

Of course, one option is simply to have a kconfig option "I am booting
from an old bootloader", but with the CP15 trick, we've tried to make
this automatic so that users don't have to understand the kind of gory
details we are discussing right now.


> > 
> > As far as I know, a DT-capable bootloader doesn't pass any ATAG. The
> > ARM register that was used to pass the pointer to the ATAGS is now used
> > to pass the pointer to the DTB in memory.
> 
> OK so one possibility could be to rely on this as well if we're certain there
> is a 1:1 relation between DT support and new mapping. But at least you have
> working code now with CP15, so let's not complexify the situation !

There is absolutely no 1:1 relation between DT support and new mapping.

As I've just written in a reply to Jason Cooper, I'm currently using a
new bootloader (which uses the new mapping at 0xf1), but I'm booting
the kernel old style (appended DTB).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
