From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Tue, 4 Dec 2012 14:53:10 +0000
Subject: Replacing dma_alloc_writecombine for aarch64
In-Reply-To: <20121203172525.GD4261@arm.com>
References: <CAD0U-h+a6_1gtTS9pq-p7_BPmNnghUMMFZAHr8JdiK1kXrEHZQ@mail.gmail.com>
 <20121203172525.GD4261@arm.com>
Message-ID: <CAD0U-hJnZftJkOGOOCPuCPgCAbiF2Eq9daLvbKaQmgORSHgQzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2012 17:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Dec 03, 2012 at 05:18:35PM +0000, Ryan Harkin wrote:
>> Some time ago, I converted the PL111 driver to use device tree [1].  I
>> gathered some feedback after an RFC and I was recently updating my
>> driver.  However, with my aarch64 work, I found that the driver
>> doesn't compile for aarch64 because I've been using
>> dma_alloc_writecombine in the driver.  As aarch64 doesn't use the
>> driver with DMA, I hacked it to get my aarch64 branch working.
>>
>> Is there another API you can recommend I use for DMA that will work
>> with both flavours?
>
> You can use dma_alloc_coherent() which gives the same thing on ARMv7
> (and some ARMv6) and AArch64 (write-combine memory). However, there is
> ARMv5 where this translates to strongly ordered memory, so you can't the
> coherent variant all the time.

Thanks, Catalin.  I'll give it a go.

I'm slightly worried about the ARMv5 comment as I probably have to
take into account that my driver may get used there, but I'll see how
it shakes out on vexpress first.

Cheers,
Ryan.
