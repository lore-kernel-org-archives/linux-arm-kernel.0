From: psandeep.s@gmail.com (sandeep patil)
Date: Fri, 18 Nov 2011 15:30:49 -0800
Subject: [Linaro-mm-sig] [PATCHv17 0/11] Contiguous Memory Allocator
In-Reply-To: <op.v45u6zyy3l0zgt@mpn-glaptop>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <CA+K6fF6SH6BNoKgwArcqvyav4b=C5SGvymo5LS3akfD_yE_beg@mail.gmail.com>
 <op.v45u6zyy3l0zgt@mpn-glaptop>
Message-ID: <CA+K6fF6iDivqmN9kfY34tWNg+g_rYBBmyS_Mxb6gvLuSgA2JyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/18 Michal Nazarewicz <mina86@mina86.com>:
> On Fri, 18 Nov 2011 22:20:48 +0100, sandeep patil <psandeep.s@gmail.com>
> wrote:
>>
>> I am running a simple test to allocate contiguous regions and write a log
>> on
>> in a file on sdcard simultaneously. I can reproduce this migration failure
>> 100%
>> times with it.
>> when I tracked the pages that failed to migrate, I found them on the
>> buffer head lru
>> list with a reference held on the buffer_head in the page, which
>> causes drop_buffers()
>> to fail.
>>
>> So, i guess my question is, until all the migration failures are
>> tracked down and fixed,
>> is there a plan to retry the contiguous allocation from a new range in
>> the CMA region?
>
> No. ?Current CMA implementation will stick to the same range of pages also
> on consequent allocations of the same size.
>

Doesn't that mean the drivers that fail to allocate from contiguous DMA region
will fail, if the migration fails?

~ sandeep
