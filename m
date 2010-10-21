From: napohybelskurwysynom2010@gmail.com (Zimny Lech)
Date: Thu, 21 Oct 2010 22:52:54 +0200
Subject: [RFC] Removal of dead code from arch/arm/*
In-Reply-To: <20101021075401.GC22100@n2100.arm.linux.org.uk>
References: <AANLkTim+vj_OAd22TdThuC-HSqUiDjguOHQWjyqFaq6N@mail.gmail.com>
	<AANLkTi=Cpq2_vV2RGcoQhrqk8xpL59AvLFPzfvTBk5Xa@mail.gmail.com>
	<4CBF8BDB.7090907@gmail.com>
	<20101021075401.GC22100@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikYtxiT+R3eb0N5U1hoDvaP=oevjWjUuAJ453p=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Oct 21, 2010 at 02:39:55AM +0200, N.P.S. wrote:
>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>> index 38c261f..fd30b75 100644
>> --- a/arch/arm/kernel/time.c
>> +++ b/arch/arm/kernel/time.c
>> @@ -37,13 +37,9 @@
>> ? */
>> ?struct sys_timer *system_timer;
>>
>> -#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
>> +#if defined(CONFIG_RTC_DRV_CMOS)
>> ?/* this needs a better home */
>> ?DEFINE_SPINLOCK(rtc_lock);
>> -
>> -#ifdef CONFIG_RTC_DRV_CMOS_MODULE
>> -EXPORT_SYMBOL(rtc_lock);
>> -#endif
>> ?#endif ? ?/* pc-style 'CMOS' RTC support */
>>
>> ?/* change this if you have some constant time drift */
>
> This is wrong, and will break the build if rtc-cmos is built as a module.
>

Ok, I dropped this patch. Recreated tree can be found here
git pull git://github.com/napohybelskurwysynom2010/Linux-2.6-nps.git rodc2

I build tested it. Now should I send every patch for review to
developers? Could you pull this tree to arm-next (2.6.38)?

Regards,
ZL

-- 
Slawa!
N.P.S.

Les fleurs du mal unfold
Comme les fleurs du mal
Dark demons of my soul
Un amour fatal
