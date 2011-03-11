From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Fri, 11 Mar 2011 11:09:02 +0530
Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
In-Reply-To: <4D78D860.2050609@ti.com>
References: <1299738148-28557-1-git-send-email-shweta.gulati@ti.com>
	<fc1162b5d4e1a7deb77aa800a3e8fdb3@mail.gmail.com>
	<4D78D860.2050609@ti.com>
Message-ID: <AANLkTiku50dsYOM0d7kYqL+AngvAhxh8_YOyfuYB65xp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 10, 2011 at 7:25 PM, Nishanth Menon <nm@ti.com> wrote:
> Few cosmetic comments follow:
> Vishwanath Sripathy wrote, on 03/10/2011 02:36 PM:
>>>
>>> -----Original Message-----
>>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
>>> kernel-bounces at lists.infradead.org] On Behalf Of Shweta Gulati
>>> Sent: Thursday, March 10, 2011 11:52 AM
>>> To: linux-omap at vger.kernel.org
>>> Cc: Shweta Gulati; linux-arm-kernel at lists.infradead.org
>>> Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
>>>
>>> OMAP4 has two different Devices IVA and DSP. DSP is bound
>>> with MPU for DVFS and IVA has its own well defined OPPs.
>>
>> DSP is not in MPU voltage domain. DSP(Tesla) and IVAHD are in the same
>> voltage domain. Pls correct this in the commit log.
>
> True for OMAP4 - DSP and MPU DVFS are independent, in OMAP3, they were
> scaled together ;)
Will correct the Commit log.
> [...]
>>>
>>> This Patch adds IVA init to 'omap2_init_processor_devices'
>>> and make sure that API 'omap2_set_init_voltage' is called
>>> for apt dev pointer.
>
> set_init_voltage error is just one symptom of the problem. infact, if we
> wanted to do anything with iva - e.g. dvfs, we would'nt have been able to
> without the device being registered.
Yes, Fair enough need to rephrase whole Log.
>>
>>> It fixes Error logs:
>
> "This also fixes the following error seen during boot as
> omap2_set_init_voltage can now find the iva device" is better than the "This
> patch...."?
Will do.
>>>
>>> ? ? ? ?omap2_set_init_voltage: Invalid parameters!
>>> ? ? ? ?omap2_set_init_voltage: Unable to put vdd_iva to its init voltage
>
> Thanks for catching and fixing this - I had noticed this in my SR 1.5
> testing(should have posted as well), but had'nt tried to dig further.
>
>>>
>>> Tested on OMAP4430 SDP Board.
>>> Baseline:
>>> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-
>>> pm.git
>>> Branch :pm-core
>
> Do you really want this information in commit log? I suggest you move this
> to the diffstat section.
Will do.
>>>
>>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>>> ---
>>> ?arch/arm/mach-omap2/pm.c | ? ?1 +
>>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>> index 30af335..49486f5 100644
>>> --- a/arch/arm/mach-omap2/pm.c
>>> +++ b/arch/arm/mach-omap2/pm.c
>>> @@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
>>> ? ? ? ?if (cpu_is_omap44xx()) {
>>> ? ? ? ? ? ? ? ?_init_omap_device("l3_main_1",&l3_dev);
>>> ? ? ? ? ? ? ? ?_init_omap_device("dsp",&dsp_dev);
>>> + ? ? ? ? ? ? ? _init_omap_device("iva",&iva_dev);
>>> ? ? ? ?} else {
>>> ? ? ? ? ? ? ? ?_init_omap_device("l3_main",&l3_dev);
>>> ? ? ? ?}
>
>
>
> --
> Regards,
> Nishanth Menon
>

-- 
Thanks,
Regards,
Shweta
