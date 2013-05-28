From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 May 2013 10:08:40 +0200
Subject: [PATCH 3/3 v3] net/macb: Try to optimize struct macb layout
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B723A@saturn3.aculab.com>
References: <cover.1368608928.git.nicolas.ferre@atmel.com>
 <d0bc206ace3baaf681e111ba07c4d0b576839bb4.1368608928.git.nicolas.ferre@atmel.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B723A@saturn3.aculab.com>
Message-ID: <51A46608.2020906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/2013 11:37, David Laight :
>> From: Havard Skinnemoen <havard@skinnemoen.net>
>
>> Move the NAPI struct below that since it is used
>> from the interrupt handler. This field is also marked as
>> ___cacheline_aligned_in_smp.
>
> Is that a good idea if the cache line size is 256 bytes?
> Indeed is that ever sane - except for a few special structures
> that really need it, and are guaranteed to be allocated
> with that much alignment.

I do not know if that was really needed, it was a recommendation by Ben.
(previous email here:
https://patchwork.kernel.org/patch/1887101/
)

Anyway, it seems that this patch needs more work whereas the others of 
the series are not commented.

So maybe, I can resend patches 1, 2 for making this big enhancement go 
forward (as it is in review process for quite a long time...).
David, do you want me to resend or can you retrieve these v3 patches in 
patchwork?

Best regards,
-- 
Nicolas Ferre
