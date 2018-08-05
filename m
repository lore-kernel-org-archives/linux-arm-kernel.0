From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 5 Aug 2018 23:51:50 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180805215150.GB1862@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Can you run the test program on x86 using the similar framebuffer
> > setup?  Does doing two writes (one aligned and one unaligned but
> > overlapping with previous one) cause the same issue?  I suspect it
> > does, then using memcpy for frame buffers is wrong.

I'm pretty sure it will work ok on x86.

> Overlapping unaligned writes work on x86 - they have to, because of 
> backward compatibility.

It is not that easy. 8086s (and similar) did not have MTRRs and PATs
either. Overlapping unaligned writes _on main memory_, _with normal
MTRR settings_ certainly work ok on x86.

Chances is memory type can be configured to work similar way on your
ARM/PCIe case?

> 8086, 80286 and 80386 didn't have any cache at all.

386s had cache (but not on die).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180805/bbf8727f/attachment.sig>
