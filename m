From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 11 Feb 2011 15:41:39 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
Message-ID: <20110211144139.GC3920@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> I'm not sure if this is the best place to bring this up, but Russel's
> name is on a fair share of drivers/mmc code, and there does seem to be
> quite a bit of MMC-related discussions. Excuse me in advance if this
> isn't the right forum :-).
> 
> Certain MMC vendors (maybe even quite a bit of them) use a pretty
> rigid buffering scheme when it comes to handling writes. There is
> usually a buffer A for random accesses, and a buffer B for sequential
> accesses. For certain Toshiba parts, it looks like buffer A is 8KB
> wide, with buffer B being 4MB wide, and all accesses larger than 8KB
> effectively equating to 4MB accesses. Worse, consecutive small (8k)
> writes are treated as one large sequential access, once again ending
> up in buffer B, thus necessitating out-of-order writing to work around
> this.

Hmmmm, I somehow assumed MMCs would be much more cleverr than this.

> reorders) them? The thresholds would then be adjustable as
> module/kernel parameters based on manfid. I'm asking because I have a
> patch now, but its ugly and hardcoded against a specific manufacturer.

How big is performance difference?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
