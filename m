From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 31 May 2016 12:29:51 +0200
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <574D64A0.2070207@arm.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
 <574D64A0.2070207@arm.com>
Message-ID: <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

>
> I remember there were some issues around 4.2 with the revision of the arm64
> atomic implementations affecting the cmpxchg_double() in SLUB, but those
> should all be fixed (and the symptoms tended to be considerably more fatal).
> A stronger candidate would be 97303480753e (which landed in 4.4), which has
> various knock-on effects on the layout of SLUB internals - does fiddling
> with L1_CACHE_SHIFT make any difference?
>

I'll check the commits, thanks. I forgot to add L1_CACHE_SHIFT was my
first suspect - I had spent a long time debugging network controller,
which stopped working because of this change - L1_CACHE_BYTES (and
hence NET_SKB_PAD) not fitting HW constraints. Anyway reverting it
didn't help at all for page alloc issue.

Best regards,
Marcin
