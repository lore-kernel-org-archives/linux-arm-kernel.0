From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 3 Nov 2015 18:04:32 +0100
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <5638E2C3.4030402@oracle.com>
References: <56377E76.2080209@sigmadesigns.com>
 <56377F09.6050805@sigmadesigns.com> <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
 <20151102182615.GI2684@leverpostej> <5637AD74.4080206@oracle.com>
 <563871A9.7050009@sigmadesigns.com> <yw1xtwp38k7r.fsf@unicorn.mansr.com>
 <5638E2C3.4030402@oracle.com>
Message-ID: <5638E920.1030009@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 17:37, Santosh Shilimkar wrote:
> On 11/3/2015 2:12 AM, M?ns Rullg?rd wrote:
>> Marc Gonzalez writes:
>>
>>> Santosh Shilimkar wrote:
>>>
>>>> Mark Rutland wrote:
>>>>
>>>>> We didn't. Having a look just now, the earliest example appears to be
>>>>> in OMAP4 L2 support patches back in 2009 [1]. I was not able to find a
>>>>> rationale.
>>>>>
>>>>> Given that the MMU is on (and speculative accesses are permitted) I
>>>>> can't see what the DSB achieves -- it can't quiesce the memory system.
>>>>>
>>>>> Santosh, any idea?
>>>>
>>>> IIRC, it was requirement from the OMAP ROM code to have a dsb before
>>>> we call the SMC routine. I can't recollect more than that now.
>>>
>>> In that case, shouldn't dsb have been added to the ROM code,
>>> on the "other side" of the smc, so as to not depend on Linux
>>> code "getting it right"?
>>
>> You're new to this, aren't you? :)
>
> :-) Indeed. ROM code is burned into the chip and can't be changed.

Oh, that kind of ROM... I thought EEPROM.
(Our secure OS is stored in NAND flash.)

If I'm bored, I'll try measuring the run-time difference with
and without dsb.

Regards.
