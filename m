From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 18 Nov 2015 15:01:26 +0800
Subject: [PATCH v3 04/62] arm/acpi: Emulate io ports for arm
In-Reply-To: <4167037.Po02bj0iif@wuerfel>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-5-git-send-email-shannon.zhao@linaro.org>
 <4167037.Po02bj0iif@wuerfel>
Message-ID: <564C2246.2010906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2015/11/17 17:50, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 17:40:03 shannon.zhao at linaro.org wrote:
>> +/*
>> + * Emulate x86 io ports for arm.
>> + */
>> +#define __armio(addr) ( (void __iomem *)addr )
>> +
>> +#define inb(c) ( readb( __armio(c) ) )
>> +#define inw(c) ( readw( __armio(c) ) )
>> +#define inl(c) ( readl( __armio(c) ) )
>> +
>> +#define outb(v, c) ( writeb(v, __armio(c) ) )
>> +#define outw(v, c) ( writew(v, __armio(c) ) )
>> +#define outl(v, c) ( writel(v, __armio(c) ) )
>> +
> 
> This is almost certainly wrong. There might be I/O port accesses, but they
> won't be in the same place as normal pointers.
> 
Sorry, maybe I didn't get what you mean. Here it just wants emulate the
in(b,w,l) and out(b,w,l) which exist on x86 while not on ARM. So it
could introduce less change to the common ACPI codes, for example
acpi_os_write_port().

I see there is the same thing in Linux arch/arm/include/asm/io.h

Thanks,
-- 
Shannon
