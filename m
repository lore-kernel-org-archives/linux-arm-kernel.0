From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 14 Sep 2011 10:56:36 +0530
Subject: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
In-Reply-To: <87wrdcbb49.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
	<87y5xteahc.fsf@ti.com> <4E6EECA3.4040704@ti.com>
	<87wrdcbb49.fsf@ti.com>
Message-ID: <CAMQu2gwtj17KTeQFA-okaPYV4KKTnvzM8FcqaO0ptm2ZEH-8=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 11:03 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh <santosh.shilimkar@ti.com> writes:
>
>> On Tuesday 13 September 2011 02:36 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar<santosh.shilimkar@ti.com> ?writes:
>>>
>>>> This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
>>>> retention (CSWR) is not supported by hardware design.
>>>>
>>>> The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>>>>
>>>> CPUx sleep code is common for hotplug, suspend and CPUilde.
>>>>
>>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>>> Cc: Kevin Hilman<khilman@ti.com>
>>>
>>> [...]
>>>
>>>> @@ -38,6 +39,11 @@ void __iomem *omap4_get_scu_base(void)
>>>>
>>>> ? void __cpuinit platform_secondary_init(unsigned int cpu)
>>>> ? {
>>>> + ? /* Enable NS access to SMP bit for this CPU on EMU/HS devices */
>>>> + ? if (cpu_is_omap443x()&& ?(omap_type() != OMAP2_DEVICE_TYPE_GP))
>>>
>>> A comment here about why this is 443x specific would be helpful.
>>>
>>> I see a comment in omap4_cpu_resume() that seems to indicate that SMP
>>> bit is accessible on 446x NS devices, but repeating that commen here
>>> would help future readability.
>>>
>> Ok. Will add comments here too. Was just trying to save some lines :)
>
> heh, this is a negative side-effect of people caring primarily about
> diffstat. :(
>
ya.

> One other comment on this patch. ?You need spaces around the '&&' above.
>
The original patch is fine for that. Some replies has eaten that space. My
Thunderbird email client is doing the same. :(

Regards
Santosh
