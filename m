From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 08 Feb 2012 10:21:18 +0100
Subject: [Linaro-mm-sig] [PATCH 11/15] mm: trigger page reclaim in
 alloc_contig_range() to stabilize watermarks
In-Reply-To: <CA+K6fF49BQiNer=7Di+gCU_EX4E41q-teXJJUBjEd2xc12-j4w@mail.gmail.com>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-12-git-send-email-m.szyprowski@samsung.com>
 <20120203140428.GG5796@csn.ul.ie>
 <CA+K6fF49BQiNer=7Di+gCU_EX4E41q-teXJJUBjEd2xc12-j4w@mail.gmail.com>
Message-ID: <op.v9cr9sqm3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Feb 2012 03:04:18 +0100, sandeep patil <psandeep.s@gmail.com> wrote:
> There's another problem I am facing with zone watermarks and CMA.
>
> Test details:
> Memory  : 480 MB of total memory, 128 MB CMA region
> Test case : around 600 MB of file transfer over USB RNDIS onto target
> System Load : ftpd with console running on target.
> No one is doing CMA allocations except for the DMA allocations done by the
> drivers.
>
> Result : After about 300MB transfer, I start getting GFP_ATOMIC
> allocation failures.  This only happens if CMA region is reserved.

[...]

> Total memory available is way above the zone watermarks. So, we ended
> up starving
> UNMOVABLE/RECLAIMABLE atomic allocations that cannot fallback on CMA region.

This looks like something Mel warned me about.  I don't really have a good
solution for that yet. ;/

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
