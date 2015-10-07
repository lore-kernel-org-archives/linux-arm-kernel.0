From: balbi@TI.COM (Felipe Balbi)
Date: Tue, 6 Oct 2015 22:07:46 -0500
Subject: [PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
In-Reply-To: <56145836.4070304@linaro.org>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
 <1444150927-14771-10-git-send-email-balbi@ti.com>
 <56145836.4070304@linaro.org>
Message-ID: <87bncb1im5.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 10/06/2015 07:02 PM, Felipe Balbi wrote:
>> Introduce a new clocksource driver for Texas
>> Instruments 32.768 Hz device which is available
>> on most OMAP-like devices.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> Hi Felipe,
>
> With the couple of nits below fixed, you can my:
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> [ ... ]
>
>> +#define OMAP2_32KSYNCNT_REV_OFF		0x0
>> +#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
>> +#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
>> +#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
>> +
>> +struct ti_32k {
>> +	void __iomem		*base;
>> +	void __iomem		*counter;
>> +	struct clocksource	cs;
>> +};
>> +#define to_ti_32k(cs)	(container_of((cs), struct ti_32k, cs))
>
> Usually a static inline is used instead of a macro for that.

not so true and also completely unnecessary, considering container_of()
already type safety ;-)

Try this:

$ git grep -e "#define.*container_of" | wc -l

no strong feelings though. I tend to prefer a macro to wrap
container_of() but won't go into an argument

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/9b073e73/attachment.sig>
