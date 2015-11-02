From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 2 Nov 2015 10:37:40 -0800
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <20151102182615.GI2684@leverpostej>
References: <56377E76.2080209@sigmadesigns.com>
 <56377F09.6050805@sigmadesigns.com> <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
 <20151102182615.GI2684@leverpostej>
Message-ID: <5637AD74.4080206@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/2/2015 10:26 AM, Mark Rutland wrote:
>>> +ENTRY(tango_smc)
>>> +	push	{lr}
>>> +	mov	ip, r1
>>> +	dsb
>>
>> Did you ever get a straight answer on the dsb here?
>
> We didn't. Having a look just now, the earliest example appears to be
> in OMAP4 L2 support patches back in 2009 [1]. I was not able to find a
> rationale.
>
> Given that the MMU is on (and speculative accesses are permitted) I
> can't see what the DSB achieves -- it can't quiesce the memory system.
>
> Santosh, any idea?
>
IIRC, it was requirement from the OMAP ROM code to have a dsb before
we call the SMC routine. I can't recollect more than that now.

Regards,
Santosh
