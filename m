From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 5 Nov 2011 19:22:44 +0100
Subject: [PATCH] PM: HIBERNATION: skip the swap size check if the
	snapshot image size is anticipative
In-Reply-To: <1320392176-3906-1-git-send-email-Barry.Song@csr.com>
References: <1320392176-3906-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20111105182244.GB6772@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Barry Song <Baohua.Song@csr.com>
> 
> Current swsusp requires swap partitions even larger than real saved pages
> due to the worst compress ratio:
> but for an embedded system, which has limited storage space, then it might
> can't give the big size partition to save snapshot.
> In the another way, some embedded systems can definitely know the most size
> needed for snapshot since they run some specific application lists.
> So this patch provides the possibility for bootloader to tell kernel even
> the system has a little snapshot partition, but it is still enough.
> For example, if the system need to save 120MB memory, origin swsusp will require
> a 130MB partition to save snapshot. but if users know 30MB is enough for them(
> compressed image will be less than 30MB), they just make a 30MB
> partition.

Would it be better to have /sys/power/... entry which would allow
configuring expected compression ratio at runtime?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
