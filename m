From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 5 Apr 2018 11:40:17 +0530
Subject: [PATCH] ARM: davinci: dm644x: remove unnecessary
 postcore_initcall()
In-Reply-To: <87b4ad61-93f4-db74-d373-9e8ac0d1a5b9@lechnology.com>
References: <20180404125759.27061-1-nsekhar@ti.com>
 <87b4ad61-93f4-db74-d373-9e8ac0d1a5b9@lechnology.com>
Message-ID: <8da02a5b-7c29-eb5d-374e-00515e1e30f6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 April 2018 09:22 PM, David Lechner wrote:
>>
>> --- a/arch/arm/mach-davinci/board-sffsdr.c
>> +++ b/arch/arm/mach-davinci/board-sffsdr.c
>> @@ -133,6 +133,12 @@ static void __init davinci_sffsdr_map_io(void)
>> ? static __init void davinci_sffsdr_init(void)
>> ? {
>> ????? struct davinci_soc_info *soc_info = &davinci_soc_info;
>> +??? int ret;
>> +
>> +??? ret = dm644x_init_devices();
>> +??? if (ret)
>> +??????? pr_warn("%s: dm644x_init_devices() failed: %d\n",
>> +??????????? __func__, ret);
> 
> dm644x_init_devices() already prints a warning in all failure cases, so
> printing another warning seems a bit redundant. It is probably OK to just
> ignore the return value here and in the similar uses above.

Alright, will fix and send v2.

Regards,
Sekhar
