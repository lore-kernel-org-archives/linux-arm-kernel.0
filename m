From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 8 Feb 2011 22:38:25 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
Message-ID: <20110208213825.GB29410@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 03:22:59PM -0600, Andrei Warkentin wrote:
> Hi,
> 
> I'm not sure if this is the best place to bring this up, but Russel's
> name is on a fair share of drivers/mmc code, and there does seem to be
> quite a bit of MMC-related discussions. Excuse me in advance if this
> isn't the right forum :-).

Searching for MMC in MAINTAINERS will get you:

MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
M:      Chris Ball <cjb@laptop.org>
L:      linux-mmc at vger.kernel.org
...

List CCed...

> Certain MMC vendors (maybe even quite a bit of them) use a pretty
> rigid buffering scheme when it comes to handling writes. There is
> usually a buffer A for random accesses, and a buffer B for sequential
> accesses. For certain Toshiba parts, it looks like buffer A is 8KB
> wide, with buffer B being 4MB wide, and all accesses larger than 8KB
> effectively equating to 4MB accesses. Worse, consecutive small (8k)
> writes are treated as one large sequential access, once again ending
> up in buffer B, thus necessitating out-of-order writing to work around
> this.
> 
> What this means is decreased life span for the parts, and it also
> means a performance impact on small writes, but the first item is much
> more crucial, especially for smaller parts.
> 
> As I've mentioned, probably more vendors are affected. How about a
> generic MMC_BLOCK quirk that splits the requests (and optionally
> reorders) them? The thresholds would then be adjustable as
> module/kernel parameters based on manfid. I'm asking because I have a
> patch now, but its ugly and hardcoded against a specific manufacturer.
> 
> Thanks,
> A
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110208/88da88a3/attachment.sig>
