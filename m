From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 27 Jul 2011 10:08:41 +0800
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <alpine.LFD.2.00.1107261502251.12766@xanadu.home>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
	<20110726104628.GP9653@n2100.arm.linux.org.uk>
	<CAMbhsRRr5FPtu-kUbcLO56=rsHkb2XNDf21-G3pymPBTcmYmRQ@mail.gmail.com>
	<20110726183958.GG1655@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107261502251.12766@xanadu.home>
Message-ID: <CAGsJ_4xFLH9-2aDQdtr6S5ugADJx-tFxO-G420WCcTDSV+azXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/27 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Tue, 26 Jul 2011, Russell King - ARM Linux wrote:
>
>> I don't think there's any plans to break the:
>>
>> linux/gpio.h -> asm/gpio.h -> mach/gpio.h
>>
>> include path at the moment, as platforms do define ARCH_NR_GPIO,
>> which has to be done before asm-generic/gpiolib.h is included.
>
> Well, this GPIO business is the biggest hurdle towards a single kernel
> image that can support multiple SOCs at the moment, and the only one for
> which I have no solution yet. ?Anything that could help removing
> mach/gpio.h from asm/gpio.h would be welcome.

After reading all the following patches,

1. use CONFIG_PHYS_OFFSET to prepare for removal of a bunch of
<mach/memory.h> files

2. move from ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size

3. convert boot_params to atag_offset

Have i lost anything for the work on 1 and 2? considering some
platforms need CONSISTENT_DMA_SIZE more than the default 2MB in
arch/arm/include/asm/memory.h, we can't remove all memory.h only by
defining CONFIG_PHYS_OFFSET and moving ARM_DMA_ZONE_SIZE to
mdesc->dma_zone_size. So CONSISTENT_DMA_SIZE should also be a left
issue except gpio.h.

>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
