From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 4 Jul 2018 22:12:18 +0200
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180628090655.GL112168@atomide.com>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com> <20180627205834.GB29478@amd>
 <20180628090655.GL112168@atomide.com>
Message-ID: <20180704201218.GC13932@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I was about to add "facepalm" emoji here, as disabling l2 cache is
> > major mistake. OTOH if you also see 20 seconds, then either there is
> > another problem, or you need to enable l2 cache, too (and I don't have
> > to feel too bad for misconfiguring it).
> 
> OK. I checked and duovero runs only at 600MHz. I can only
> get down to 19 seconds with omap2plus_defconfig if I disable
> CONFIG_CPU_FREQ so the max speed is maintained from bootloader.
> Otherwise it runs at most at 1GHz, I think any higher speeds
> need smartreflex and voltage scaling working which we don't
> have in the mainline kernel. Not sure what happens with higher
> speeds with mainline kernel or if they are unsafe in the long
> run.
> 
> Anyways, care to post your .config somewhere so I can see what
> the numbers are for me with it?

I'm attaching config I'm using for v4.18. In current boot, bzip2 takes
16 seconds.

user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  sudo nice
-n -19 bzip2 -9 - | wc -c
10044705
15.68user 0.53system 15.93 (0m15.931s) elapsed 101.82%CPU

I guess I should go back to v4.17 to get 12 seconds..?!

Confused,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/gzip
Size: 29025 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/2d45ee9c/attachment-0001.gz>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/2d45ee9c/attachment-0001.sig>
