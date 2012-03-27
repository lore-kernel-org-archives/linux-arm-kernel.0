From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 27 Mar 2012 11:01:49 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
Message-ID: <20120327090148.GB6790@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >does that attached patch fix your problem ?
> 
> YES, indeed it does to a certain degree. The timeout errors do not
> occur anymore and I can successfully perform many fs->ops, such as

Interesting question is now why it worked on your older kernel? The code
around BROKEN_TIMEOUT is there for much longer, I'd think.

> The speed of the card is excruciatingly slow, however. We roughly
> get between 34KB/s and 64KB/s from a dd if=/dev/zero write to any of
> the following partitions:

Check the code below what is patched. That's currently the best solution
for the errata. There might be better ones, though, but you'd need to
find out.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120327/0b5c95e0/attachment.sig>
