From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 22 Oct 2010 15:33:43 -0400
Subject: [PATCH v3 01/12] misc: add driver for sequencer serial port
In-Reply-To: <201010221448.17728.arnd@arndb.de>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>
	<20101021161224.b4c0b623.akpm@linux-foundation.org>
	<4CC18605.80007@ti.com> <201010221448.17728.arnd@arndb.de>
Message-ID: <4CC1E717.7070707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2010 08:48 AM, Arnd Bergmann wrote:
> On Friday 22 October 2010 14:39:33 Cyril Chemparathy wrote:
>>>> +/* Register Access Helpers */
>>>> +static inline u32 ssp_read(struct ti_ssp *ssp, int reg)
>>>> +{
>>>> +    return __raw_readl(ssp->regs + reg);
>>>> +}
>>>> +
>>>> +static inline void ssp_write(struct ti_ssp *ssp, int reg, u32 val)
>>>> +{
>>>> +    __raw_writel(val, ssp->regs + reg);
>>>> +}
>>>
>>> Why are the __raw functions used here?
>>>
>>
>> These registers are to be accessed native endian at all times, and
>> therefore the le32 conversion done otherwise is inappropriate.
> 
> Won't that break on out-of-order CPUs that need the extra synchronization
> done in readl/writel?
> 

AFAICS, ioremap()ed space on ARMv6 should be strongly ordered.

>
> ...
>

Thanks
Cyril.
