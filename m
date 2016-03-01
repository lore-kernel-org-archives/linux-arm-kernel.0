From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 1 Mar 2016 16:19:37 +0000
Subject: [PATCH 3/8] ARM64: dts: Prepare configs for Amlogic Meson GXBaby
In-Reply-To: <56D5B2D5.9010405@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-4-git-send-email-afaerber@suse.de>
 <56D5AA87.7020401@arm.com> <56D5B2D5.9010405@suse.de>
Message-ID: <56D5C119.8070609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/03/16 15:18, Andreas F?rber wrote:
> Am 01.03.2016 um 15:43 schrieb Sudeep Holla:
>> On 29/02/16 23:44, Andreas F?rber wrote:
>>> +    psci {
>>> +        compatible = "arm,psci";
>>
>> Any particular reason why PSCI v0.2 or above is not supported on this
>> platform. PSCI v0.1 is very old now and I assume this platform is
>> relatively new.
>
> I am not affiliated with Amlogic or Tronsmart, so I cannot answer why.
>

OK

>>> +        method = "smc";
>>> +        cpu_suspend = <0xc4000001>;
>>> +        cpu_off = <0x84000002>;
>>> +        cpu_on = <0xc4000003>;
>>> +        migrate = <0xc4000005>;
>>
>> Atleast the functions ids look like v0.2 or above. So check if it's
>> actually v0.2 or above
>
> If you let me know how! Just change the compatible string to -0.2 and
> wait for some big boom or watch out for any misbehavior in particular?

Not exactly. Just having -0.2 in compatible will issue PSCI_VERSION
which *should be* available in v0.2 and above. If you get error there,
then we can *assume* it's PSCI v0.1. Hopefully it be sanely return
error if that's not implemented.

Note that we can only assume, as it might be v0.2 but missed to
implement PSCI_VERSION which is mandatory though.

> Are there any memory locations to check the version or something visible
> in U-Boot source code indicating it?
>

Ah so, PSCI is implemented in U-Boot on this platform ? If so, and if
the source is available it should not be that hard to figure that out.

-- 
Regards,
Sudeep
