From: w@1wt.eu (Willy Tarreau)
Date: Wed, 22 May 2013 19:08:07 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522190004.67880320@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164928.GD27348@1wt.eu> <20130522190004.67880320@skate>
Message-ID: <20130522170807.GE27348@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 07:00:04PM +0200, Thomas Petazzoni wrote:
> Yes, they could upgrade. But as of today, such upgrades do not even
> exist for the Mirabox and OpenBlocks AX3 boards. So what do we tell to
> those users?

I was assuming these boot loaders do already exist if they're shipping
on some devices, but maybe not all yet.

> Of course, one option is simply to have a kconfig option "I am booting
> from an old bootloader", but with the CP15 trick, we've tried to make
> this automatic so that users don't have to understand the kind of gory
> details we are discussing right now.

Same as for ATAGS right now which are not necessarily the most obvious
setting for end users. Better keep the trick on by default if it's safe
enough. In fact I'm mostly concerned about the risk that it later breaks
for even newer boot loaders. But then we'll have more feedback to decide.

> > > As far as I know, a DT-capable bootloader doesn't pass any ATAG. The
> > > ARM register that was used to pass the pointer to the ATAGS is now used
> > > to pass the pointer to the DTB in memory.
> > 
> > OK so one possibility could be to rely on this as well if we're certain there
> > is a 1:1 relation between DT support and new mapping. But at least you have
> > working code now with CP15, so let's not complexify the situation !
> 
> There is absolutely no 1:1 relation between DT support and new mapping.
>
> As I've just written in a reply to Jason Cooper, I'm currently using a
> new bootloader (which uses the new mapping at 0xf1), but I'm booting
> the kernel old style (appended DTB).

OK, that was what I was wondering about. Sorry for having bothere you with
my questions but at least not it's much clearer that CP15 probably is the
only viable solution.

Best regards,
Willy
