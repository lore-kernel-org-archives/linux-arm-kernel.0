From: gnurou@gmail.com (Alexandre Courbot)
Date: Sun, 20 Mar 2016 15:49:15 +0900
Subject: [PATCH v2] ARM: DMA: Fix kzalloc flags in __dma_alloc
In-Reply-To: <20160318105833.GF19428@n2100.arm.linux.org.uk>
References: <1458293329-5519-1-git-send-email-acourbot@nvidia.com>
 <20160318105833.GF19428@n2100.arm.linux.org.uk>
Message-ID: <CAAVeFuJ16c-q-RX+QxxM5-8RK7=KDSeqsJ5C00VA6-j_s3ASdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 7:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 18, 2016 at 06:28:49PM +0900, Alexandre Courbot wrote:
>> Commit 19e6e5e5392b ("ARM: 8547/1: dma-mapping: store buffer
>> information") allocates a structure meant for internal buffer management
>> with the GFP flags of the buffer itself. This can trigger the following
>> safeguard in the slab/slub allocator:
>>
>>       if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
>>               pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
>>               BUG();
>>       }
>>
>> Fix this by filtering the flags that make the slab allocator unhappy.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Rabin Vincent <rabin@rab.in>
>
> Looks much better than the original.  Please send it to the patch system,
> thanks.

Just did that, thanks!
