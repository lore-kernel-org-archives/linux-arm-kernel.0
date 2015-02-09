From: wangbintian@gmail.com (Brent Wang)
Date: Mon, 9 Feb 2015 11:26:55 +0800
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <54D4843E.7060201@arm.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
 <20150205193017.GF20735@leverpostej>
 <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
 <54D4843E.7060201@arm.com>
Message-ID: <CAAS=xmgNMgm6NFVUs5p+TNrf4MHiCsjzR1eSK84o5o5MApGOkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

2015-02-06 17:07 GMT+08:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 06/02/15 08:42, Brent Wang wrote:
>
> [...]
>
>>>
>>>> +                   <0x0 0xf6802000 0x0 0x2000>, /* GICC */
>>>> +                   <0x0 0xf6804000 0x0 0x2000>, /* GICH */
>>>> +                   <0x0 0xf6806000 0x0 0x2000>; /* GICV */
>>>
>>> I guess no-one's bothered to consider 64k pages?
>>>
>>> Given GICH and GICV, I hope that this platform is booted at EL2?
>> Transfer from EL3 to EL1 directly, keep these two just for future use.
>
> That's a real shame, as it keeps users away from some key aspects of the
> ARMv8 architecture.
>
>>>
>>>> +             #interrupt-cells = <3>;
>>>> +             #address-cells = <0>;
>>>> +             interrupt-controller;
>
> And if you're keeping GICH/GICV, where is the maintenance interrupt?
>
>>>> +     };
>>>> +
>>>> +
>>>> +     timer {
>>>> +             compatible = "arm,armv8-timer";
>>>> +             interrupt-parent = <&gic>;
>>>> +             interrupts = <1 13 0xff08>,
>>>> +                          <1 14 0xff08>,
>>>> +                          <1 11 0xff08>,
>>>> +                          <1 10 0xff08>;
>>>> +             clock-frequency = <1200000>;
>>>> +     };
>>>
>>> NAK. Fix your firmware to configure CNTFRQ, on all CPUs.
>> Fix in next version, maybe it will take some time to change firmware.
>
> While you're at it, make sure CNTVOFF_EL2 is set to zero on all CPUs
> before dropping to EL1. This tends to be overlooked.
Thank you for reminding me, I will keep that in mind.

Thanks,

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

-- 
Best Regards,

Bintian
===========================
Don't be nervous, just be happy!
