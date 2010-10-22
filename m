From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 22 Oct 2010 08:39:33 -0400
Subject: [PATCH v3 01/12] misc: add driver for sequencer serial port
In-Reply-To: <20101021161224.b4c0b623.akpm@linux-foundation.org>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>	<1287694873-12904-2-git-send-email-cyril@ti.com>
	<20101021161224.b4c0b623.akpm@linux-foundation.org>
Message-ID: <4CC18605.80007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2010 07:12 PM, Andrew Morton wrote:
>
> ...
>
>> +/* Register Access Helpers */
>> +static inline u32 ssp_read(struct ti_ssp *ssp, int reg)
>> +{
>> +	return __raw_readl(ssp->regs + reg);
>> +}
>> +
>> +static inline void ssp_write(struct ti_ssp *ssp, int reg, u32 val)
>> +{
>> +	__raw_writel(val, ssp->regs + reg);
>> +}
> 
> Why are the __raw functions used here?
> 

These registers are to be accessed native endian at all times, and
therefore the le32 conversion done otherwise is inappropriate.

Thanks for the feedback.  I will post an updated series with these changes.

Regards
Cyril.
