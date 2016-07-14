From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 14 Jul 2016 14:18:08 -0400
Subject: [PATCH] ARM: dts: NSP: Correct RAM amount for BCM958625HR board
In-Reply-To: <5786B159.7060102@gmail.com>
References: <1468433929-12232-1-git-send-email-jon.mason@broadcom.com>
 <5786B159.7060102@gmail.com>
Message-ID: <CAC3K-4ra7wmhqUi_Tc5KrML5uJGLX7-YPF1Upt=7juuTBM6QeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 5:23 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 07/13/2016 11:18 AM, Jon Mason wrote:
>> The BCM958625HR board has 2GB of RAM available.  Increase the amount
>> from 512MB to 2GB and add the device type to the memory entry.
>>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> ---
>>  arch/arm/boot/dts/bcm958625hr.dts | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
>> index 4239e58..66c658a 100644
>> --- a/arch/arm/boot/dts/bcm958625hr.dts
>> +++ b/arch/arm/boot/dts/bcm958625hr.dts
>> @@ -47,7 +47,8 @@
>>       };
>>
>>       memory {
>> -             reg = <0x60000000 0x20000000>;
>> +             device_type = "memory";
>> +             reg = <0x60000000 0x40000000>;
>
> That's just one 1GB, did you intend to provide 0x8000_0000 instead here?

Good catch!  I'll fix that up in v2 (and add a "Fixes:" referencing
the original patch).

Thanks,
Jon

> --
> Florian
