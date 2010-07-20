From: david.yangshuai@gmail.com (David Yang)
Date: Tue, 20 Jul 2010 11:17:38 +0800
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <1279542557.10760.21.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTikiHfOL0WMjiZnWY3RVmw89hZVFcNkqfDUYSDgG@mail.gmail.com>
	<1279542557.10760.21.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTinPlxiyIV9rWAIc0CR_MTymXXqNLZAu-P8OvEHK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 8:29 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Sat, 2010-07-17 at 08:05 +0100, David Yang wrote:
>> I have a question: in linux-2.6.28, there is no barriers in the IO
>> accessors.
>
> Because in 2.6.28 we used Strongly Ordered memory for the coherent DMA
> buffers and on many CPUs SO accesses are ordered relatively to Device
> accesses. But that even this isn't guaranteed by the ARM ARM.
>

Yes, I know that.

But I mean that ,in linux-2.6.28,whether the order between the IO
access will be re-ordered at the hardware level? And whether we should
use the wmb() to guarantee the order? Here we just talk about the IO
register access,without the normal memory or coherent DMA buffers.

Thank you!
