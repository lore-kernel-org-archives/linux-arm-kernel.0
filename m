From: linux-arm@myspectrum.nl (Jeroen Hofstee)
Date: Fri, 10 Apr 2015 23:29:13 +0200
Subject: [RESEND][PATCH] ARM errata, 430973: update the affected revisions
In-Reply-To: <54EE2453.9080301@myspectrum.nl>
References: <1418131842-6752-1-git-send-email-jhofstee@victronenergy.com>
 <54EE2453.9080301@myspectrum.nl>
Message-ID: <552840A9.8070406@myspectrum.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On 25-02-15 20:36, Jeroen Hofstee wrote:
> Hi,
>
> On 09-12-14 14:30, Jeroen Hofstee wrote:
>> From: Jeroen Hofstee <linux-arm@myspectrum.nl>
>>
>> Update the list of revisions subject to this errata.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Andreas Bie?mann <andreas.devel@googlemail.com>
>> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
>> ---
>> I don't have access to the AT400/AT401/AT490 document, but
>> Andreas was kind enough to provide this information, see
>> https://www.mail-archive.com/u-boot at lists.denx.de/msg156620.html
>>
>> Resending from an address which is subscribed to the ML...
>> ---
>>   arch/arm/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 89c4b5c..a2202fa 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1063,7 +1063,7 @@ config ARM_ERRATA_430973
>>       depends on CPU_V7
>>       help
>>         This option enables the workaround for the 430973 Cortex-A8
>> -      (r1p0..r1p2) erratum. If a code sequence containing an ARM/Thumb
>> +      (r1p0..r1p3, r1p7) erratum. If a code sequence containing an 
>> ARM/Thumb
>>         interworking branch is replaced with another code sequence at 
>> the
>>         same virtual address, whether due to self-modifying code or 
>> virtual
>>         to physical address re-mapping, Cortex-A8 does not recover 
>> from the
>
> It seems this is not applied yet. For completeness, this only updates 
> the description
> of the workaround, so should be safe to apply. At the moment people 
> might disable
> this workaround (since the description says its not applicable) even 
> if the cpu does
> need this workaround.
>
> Please consider applying this,
>

ping

This still seems not be be applied. Please do update the documentation 
because it
causes segfaults when disabled wrongly. Below is a discussion about the 
topic as well.

Regards,
Jeroen

http://lists.denx.de/pipermail/u-boot/2014-December/198092.html
