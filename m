From: nm@ti.com (Nishanth Menon)
Date: Wed, 02 Mar 2011 22:30:54 +0530
Subject: [PATCH v2 15/18] omap3+: sr: disable spamming interrupts
In-Reply-To: <4D6E49E9.1020307@ru.mvista.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
	<1299063331-27968-16-git-send-email-nm@ti.com>
	<4D6E49E9.1020307@ru.mvista.com>
Message-ID: <4D6E77C6.209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote, on 03/02/2011 07:15 PM:
[...]
>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>> b/arch/arm/mach-omap2/smartreflex.c
>> index 49a04ea..d62da3d 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -209,8 +209,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
>> value = irqstat_to_notifier_v2(status);
>> }
>>
>> - if (sr_class->notify)
>> - sr_class->notify(sr_info->voltdm, value);
>> + /* Attempt some resemblence of recovery! */
>
> Resemblance?
arrgh.. thanks for catching :)

-- 
Regards,
Nishanth Menon
