From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 01 Jul 2013 17:14:25 +0200
Subject: [PATCH] DMA: Fix Marvell Orion and mv_xor after MEMSET removal
In-Reply-To: <20130701150407.GB19937@titan.lakedaemon.net>
References: <1372690589-2218-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130701150407.GB19937@titan.lakedaemon.net>
Message-ID: <51D19CD1.3030900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/13 17:04, Jason Cooper wrote:
> On Mon, Jul 01, 2013 at 04:56:29PM +0200, Sebastian Hesselbarth wrote:
>> Commit 834cbfe966bece50afded79da8e975d255bf0772
>>   ("drivers/dma: remove unused support for MEMSET operations")
>> removes MEMSET from dmaengine but does not completely removes it from
>> Marvell Orion (arch/arm/plat-orion) and XOR (drivers/dma/mv_xor).
>> This also fixes some compiler warnings about now obsolete functions by
>> removing those.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> ---
>>   arch/arm/plat-orion/common.c |    6 ------
>>   drivers/dma/mv_xor.c         |   25 +------------------------
>>   2 files changed, 1 insertions(+), 30 deletions(-)
>
> Please take a look at the email from lkml I just forwarded to you.  I
> believe this solves your problem, but I don't have time to look closely
> atm.

Jason,

I have seen the forwarded patch before. I don't know what version this
is based on. Some of the modifications are in next-20130701, some are
not. I have stripped the Marvell modifications from the patch you
forwarded and fixed all remaining issues.

Also, I will sent a follow-up patch to remove memset references from
Marvell SoC dts/dtsi and the binding documentation soon.

I guess, Bartolomiej should pick them up and resend his patch set, or
leave Marvell alone and you pick them up.

Sebastian
