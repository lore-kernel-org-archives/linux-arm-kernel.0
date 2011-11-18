From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 18 Nov 2011 22:26:49 +0100
Subject: [Linaro-mm-sig] [PATCHv17 0/11] Contiguous Memory Allocator
In-Reply-To: <CA+K6fF6SH6BNoKgwArcqvyav4b=C5SGvymo5LS3akfD_yE_beg@mail.gmail.com>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <CA+K6fF6SH6BNoKgwArcqvyav4b=C5SGvymo5LS3akfD_yE_beg@mail.gmail.com>
Message-ID: <op.v45u6zyy3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Nov 2011 22:20:48 +0100, sandeep patil <psandeep.s@gmail.com> wrote:
> I am running a simple test to allocate contiguous regions and write a log on
> in a file on sdcard simultaneously. I can reproduce this migration failure 100%
> times with it.
> when I tracked the pages that failed to migrate, I found them on the
> buffer head lru
> list with a reference held on the buffer_head in the page, which
> causes drop_buffers()
> to fail.
>
> So, i guess my question is, until all the migration failures are
> tracked down and fixed,
> is there a plan to retry the contiguous allocation from a new range in
> the CMA region?

No.  Current CMA implementation will stick to the same range of pages also
on consequent allocations of the same size.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
