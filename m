From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Aug 2011 09:56:14 +0200
Subject: [PATCH v3] amba: consolidate PrimeCell magic
In-Reply-To: <20110817184905.GA11221@n2100.arm.linux.org.uk>
References: <1313569846-22902-1-git-send-email-linus.walleij@stericsson.com>
	<ADE657CA350FB648AAC2C43247A983F001F3884BB382@AUSP01VMBX24.collaborationhost.net>
	<20110817184905.GA11221@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaWCuPjjVmKHKvZfC_aaaQZgm6qHvyY5MN-o8T3FJ6x5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 8:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 17, 2011 at 12:03:57PM -0500, H Hartley Sweeten wrote:
>> > + ? cellid = amba_get_pid((void __iomem *)((u32)base & PAGE_MASK), SZ_4K);
>>
>> This produces a sparse warning. ?But, the same warning was present with the
>> old code.
>>
>> arch/arm/common/vic.c:353:49: warning: cast removes address space of expression
>
> That's prabably because casting from a pointer to a u32 (unsigned int)
> isn't the best thing to do. ?Casting to unsigned long is much better,
> and iirc doesn't provoke such a sparse warning.

Yep it's correct, sparse is silent on me now, posting v4.

Thanks!
Linus Walleij
