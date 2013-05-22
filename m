From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 20:05:13 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522171359.GG31290@titan.lakedaemon.net>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
 <20130522171359.GG31290@titan.lakedaemon.net>
Message-ID: <20130522200513.5e266edc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 22 May 2013 13:13:59 -0400, Jason Cooper wrote:

> > On Wed, 22 May 2013 12:49:36 -0400, Jason Cooper wrote:
> > 
> > > > As far as I know, a DT-capable bootloader doesn't pass any ATAG. The
> > > > ARM register that was used to pass the pointer to the ATAGS is now used
> > > > to pass the pointer to the DTB in memory.
> > > 
> > > So we could look for the ATAG magic or the dtb magic at that address,
> > > then we know if we have an old or new bootloader...
> > 
> > No, because you can use an old bootloader, and still do some old-style
> 
> Did you mean 'new bootloader'?

Gaah, yes, of course. Getting myself confused with all this old/new
discussion :)

"No, because you can use a new bootloader, and still do some
old-style..."

> > appended-DTB booting, in which case you have a new bootloader
> > (registers mapped at 0xf1), but you see the ATAG magic, which will make
> > you think you booted from an old bootloader (registers mapped at 0xd0).
> > 
> > For example, I'm currently booting alternatively with an old and a new
> > bootloader (to test that things work properly), and in both cases I'm
> > booting old style, DTB-appended, with ATAGs.
> 
> Is this something users would experience?  I think it is fairly safe to
> say that once dt-able bootloaders are shipped, they will provide a dtb.
> So, OF_DT_MAGIC == new bootloader might hold true for users.

We could be tempted to say that, but since what users trying to do this
would experience is a completely silent kernel, no message, nothing,
I'm not sure I like this too much.

Especially since users of the mainline kernel for Marvell platforms
have become used to do the appended DTB gymnastic, it's pretty likely
that they will do the same gymnastic when they'll move to more recent
Marvell platforms or bootloaders, not necessarily knowing that the
bootloader is now capable of doing DT-based booting.

Therefore, I continue to believe that making the assumptions that being
booted from DT == new bootloader == new mapping, being booted from ATAGS
== old boot == old mapping, should not be made.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
