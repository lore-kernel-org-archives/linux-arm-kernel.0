From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 26 Oct 2014 22:55:48 +0100
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <201410262222.39892@pali>
References: <20141019090107.GA19132@amd> <201410261212.46582@pali>
 <20141026211721.GA7351@amd> <201410262222.39892@pali>
Message-ID: <20141026215548.GA9004@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I have root prepared on /dev/mmcblk0p6. I tried 3.17 with
> > rx51_defconfig, but no, it refuses to mount it.
> > 
> > VFS: Cannot open root device "mmcblk0p6" or ....: error -19.
> > 
> > And then it proceeds to list mmcblk0p6 as one of available
> > options
> > 
> > :-(.
> > 
> > Ideas welcome.
> 
> Try to add rootdelay=30 or rootwait to kernel cmdline.

I had rootdelay=3. Will try rootwait... no change. This is v3.17 with
rx51_defconfig. CONFIG_MACH_NOKIA_RX51=y => device tree will not be
used AFAICT.

Now I'm back at 3.14 without device tree; same setup works there. I
tried disabling RX51 support in 3.14 (to make it boot using device
tree) but that did not work.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
