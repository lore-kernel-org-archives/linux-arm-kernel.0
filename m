From: mina86@mina86.com (Michal Nazarewicz)
Date: Sat, 19 Nov 2011 19:09:23 +0100
Subject: [Linaro-mm-sig] [PATCHv17 0/11] Contiguous Memory Allocator
In-Reply-To: <CA+K6fF6iDivqmN9kfY34tWNg+g_rYBBmyS_Mxb6gvLuSgA2JyQ@mail.gmail.com>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <CA+K6fF6SH6BNoKgwArcqvyav4b=C5SGvymo5LS3akfD_yE_beg@mail.gmail.com>
 <op.v45u6zyy3l0zgt@mpn-glaptop>
 <CA+K6fF6iDivqmN9kfY34tWNg+g_rYBBmyS_Mxb6gvLuSgA2JyQ@mail.gmail.com>
Message-ID: <op.v47gpxi03l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On Fri, 18 Nov 2011 22:20:48 +0100, sandeep patil wrote:
>>> So, i guess my question is, until all the migration failures are
>>> tracked down and fixed, is there a plan to retry the contiguous
>>> allocation from a new range in the CMA region?

> 2011/11/18 Michal Nazarewicz <mina86@mina86.com>:
>> No.  Current CMA implementation will stick to the same range of pages also
>> on consequent allocations of the same size.

On Sat, 19 Nov 2011 00:30:49 +0100, sandeep patil <psandeep.s@gmail.com> wrote:
> Doesn't that mean the drivers that fail to allocate from contiguous DMA region
> will fail, if the migration fails?

Yes.

I have some ideas how that could be mitigated.  The easiest would be to try
another region to allocate from on failure.  More complicated could be to try
and wait for the I/O transfer to finish.  I'll try to work on it during
upcoming week.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
