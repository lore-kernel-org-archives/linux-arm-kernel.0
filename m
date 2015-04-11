From: linux-arm@myspectrum.nl (Jeroen Hofstee)
Date: Sat, 11 Apr 2015 11:25:32 +0200
Subject: [RESEND][PATCH] ARM errata, 430973: update the affected revisions
In-Reply-To: <20150411075220.GK12732@n2100.arm.linux.org.uk>
References: <1418131842-6752-1-git-send-email-jhofstee@victronenergy.com>
 <54EE2453.9080301@myspectrum.nl> <552840A9.8070406@myspectrum.nl>
 <20150411075220.GK12732@n2100.arm.linux.org.uk>
Message-ID: <5528E88C.4070107@myspectrum.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell, +Tony,

Thanks for taking the time to respond,

On 11-04-15 09:52, Russell King - ARM Linux wrote:
> On Fri, Apr 10, 2015 at 11:29:13PM +0200, Jeroen Hofstee wrote:
>> On 25-02-15 20:36, Jeroen Hofstee wrote:
>>> On 09-12-14 14:30, Jeroen Hofstee wrote:
>>>> From: Jeroen Hofstee <linux-arm@myspectrum.nl>
>>>>
>>>> Update the list of revisions subject to this errata.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>>>> Cc: Andreas Bie?mann <andreas.devel@googlemail.com>
>>>> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
>>>> ---
>>>> I don't have access to the AT400/AT401/AT490 document, but
>>>> Andreas was kind enough to provide this information, see
>>>> https://www.mail-archive.com/u-boot at lists.denx.de/msg156620.html
>>>>
>>>> Resending from an address which is subscribed to the ML...
>>>> ---
>>>>   arch/arm/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 89c4b5c..a2202fa 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1063,7 +1063,7 @@ config ARM_ERRATA_430973
>>>>       depends on CPU_V7
>>>>       help
>>>>         This option enables the workaround for the 430973 Cortex-A8
>>>> -      (r1p0..r1p2) erratum. If a code sequence containing an ARM/Thumb
>>>> +      (r1p0..r1p3, r1p7) erratum. If a code sequence containing an
>>>> ARM/Thumb
>>>>         interworking branch is replaced with another code sequence at
>>>> the
>>>>         same virtual address, whether due to self-modifying code or
>>>> virtual
>>>>         to physical address re-mapping, Cortex-A8 does not recover from
>>>> the
>>>
> No.  If you read the discussion that the OMAP people are having, it is
> unclear whether r3p2 is actually affected by this errata or not.
I scanned through it, but that is a different issue it seems. This patch
only adds r1p3 and r1p7 to the documentation, since according to ARM
they are affected by this errata. Newer revision should not be affected
by this errata (or ARM reintroduced it).

The patch is _not_ adding r3p2 as an affected version. And is also not
about how to deal with cores no longer needing this workaround.

> In the discussion with OMAP people, we've come up with a potentially
> better solution to this, which is to rearrange the code so that only
> Cortex-A8 executes this workaround, and the BTB flush is always
> present (which Tony says fixes the problem.)

The am3517 / r1p7 is a Cortex-a8 and is affected by this errata. I fail to
see why making this cortex-a8 specific will help anything about the revision
not being mentioned in the help text. (unless the CONFIG option gets 
completely
removed).
> Meanwhile, OMAP people are seeing about updating uboot to set/clear
> the auxiliary control register bit appropriately for the revision of
> the core.
Well almost appropriately. [1] suggest "the bootloaders can be fixed 
Cortex-A8
revisions later than r1p2 to not set the IBE bit.". That should have 
been r1p7 as
well.

> In any case, adding the patch and suggesting people enable this for
> more Cortex-A8's (eg, non-OMAP) won't actually do anything in a
> multiplatform kernel.
>
Can you give an example of a r1p7 not needing the workaround?

Regards,
Jeroen

http://www.spinics.net/lists/arm-kernel/msg411297.html
