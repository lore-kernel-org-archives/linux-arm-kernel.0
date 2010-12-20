From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 08:45:31 -0600
Subject: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
In-Reply-To: <AANLkTims4Hfzyh-MpTZKpwROwAH5DCGo2FQBJd9DKcQt@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>	<1292712817-24999-5-git-send-email-nm@ti.com>
	<AANLkTims4Hfzyh-MpTZKpwROwAH5DCGo2FQBJd9DKcQt@mail.gmail.com>
Message-ID: <4D0F6C0B.8010100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet had written, on 12/20/2010 04:27 AM, the following:
[..]
>> Workaround is to disable RTA on boot and coming out of core off.
>> For disabling rta coming out of off mode, we do this by overriding the
> Use caps for RTA
Thanks. done.
> 
>> restore pointer for 3630 to allow us restore handler as the first point of
> This is not clear, maybe 'to allow us to restore handler' needs to be removed.
Thanks. done.

> 
>> entry before caches are touched and is common for GP and HS devices.
>> to disable earlier than this could be possible by modifying the ppa for HS
> Same here, it looks like the original sentence has been cut in pieces.
> Use caps for PPA.
Thanks. done.
[..]
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 5702f41..b32a2ed 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
[..]
>> @@ -1067,6 +1069,14 @@ static int __init omap3_pm_init(void)
>>        pm_idle = omap3_pm_idle;
>>        omap3_idle_init();
>>
>> +       /*
>> +        * RTA is disabled during initialization as per erratum i608
>> +        * it is safer to disable rta by the bootloader, but we would like
> Use caps for RTA
thanks. Done.

>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
>> index 3fbd1e5..cc3507b 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S

[..]
>> +restore_3630:
>> +       /*b restore_es3630*/            @ Enable to debug restore code
>> +       ldr     r1, pm_prepwstst_core_p
>> +       ldr     r2, [r1]
>> +       and     r2, r2, #0x3
>> +       cmp     r2, #0x0        @ Check if previous power state of CORE is OFF
>> +       bne     restore
>> +       /* Disable rta before giving control */
> Use caps for RTA
Thanks. Done.
[..]


-- 
Regards,
Nishanth Menon
