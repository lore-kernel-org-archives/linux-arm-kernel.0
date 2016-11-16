From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 16 Nov 2016 07:53:24 +0100
Subject: Default atomic_pool_size value & changing it
In-Reply-To: <CACna6rwQp+kzkBBOJ7Jv=AGibqA9XK2qj4pqXUnJwUGg29BpZg@mail.gmail.com>
References: <CACna6ryHrkhxF-HKDB-+if=7XC9D=89oTEVyR9PJWpYAWnoVzw@mail.gmail.com>
 <20161115213706.GZ1041@n2100.armlinux.org.uk>
 <CACna6rwQp+kzkBBOJ7Jv=AGibqA9XK2qj4pqXUnJwUGg29BpZg@mail.gmail.com>
Message-ID: <CACna6rxT1EZMpVA6J+PNd3ZDxrsbyBAnRmt6EOtB3fyXKwx4zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2016 at 22:43, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> On 15 November 2016 at 22:37, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Tue, Nov 15, 2016 at 10:15:51PM +0100, Rafa? Mi?ecki wrote:
>>> I've hit problem with allocating enough coherent DMA memory. Obviously
>>> there is a limit of this memory as pointed by:
>>> [ 0.283667] DMA: preallocated 256 KiB pool for atomic coherent allocations
>>
>> This is for _atomic_ coherent allocations, not for normal coherent
>> allocations.  Normal coherent allocations come from the CMA memory.
>> Make sure you have CMA enabled, and you have enough of it.
>>
>> Boot with cma=xxxMB with xxx set appropriately.
>
> Oh, that definitely sounds like worth trying
> # CONFIG_CMA is not set
> thanks for pointing it to me!

For my quick testing I silly used:
cpu_addr[i] = dma_zalloc_coherent(dev, size, &dma_addr[i], GFP_ATOMIC);
which obviously shouldn't be done in non-sleep mode and shouldn't need
GFP_ATOMIC.

I got it now, thanks again.

-- 
Rafa?
