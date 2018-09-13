From: sed@free.fr (Cedric Roux)
Date: Thu, 13 Sep 2018 22:26:55 +0200
Subject: [PATCH v3 1/2] ARM: s3c24xx: formatting cleanup in mach-mini2440.c
In-Reply-To: <b97d7ccc921572ca5d783584eea1de04341ab02f.camel@perches.com>
References: <20180907215446.15160-1-sed@free.fr>
 <b97d7ccc921572ca5d783584eea1de04341ab02f.camel@perches.com>
Message-ID: <4cf38559-b00d-ede4-def5-7cd832d8a506@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/12/2018 09:21 PM, Joe Perches wrote:
> On Fri, 2018-09-07 at 23:54 +0200, Cedric Roux wrote:
>> Running:
>>     scripts/checkpatch.pl -f arch/arm/mach-s3c24xx/mach-mini2440.c
>> revealed several errors and warnings.
>>
>> They were all removed, except one which is an #if 0 around the declaration
>> of a gpio pin. This needs some more investigation and I prefer to let it
>> here. This is not some dead code.
> []
>> diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
> []
>> @@ -674,17 +680,17 @@ static void __init mini2440_init(void)
>>  		mini2440_fb_info.displays =
>>  			&mini2440_lcd_cfg[features.lcd_index];
>>  
>> -		printk(KERN_INFO "MINI2440: LCD");
>> +		pr_info("MINI2440: LCD");
> 
> OK
> 
>>  		for (li = 0; li < ARRAY_SIZE(mini2440_lcd_cfg); li++)
>>  			if (li == features.lcd_index)
>> -				printk(" [%d:%dx%d]", li,
>> +				pr_info(" [%d:%dx%d]", li,
>>  					mini2440_lcd_cfg[li].width,
>>  					mini2440_lcd_cfg[li].height);
> 
> pr_cont
> 
>>  			else
>> -				printk(" %d:%dx%d", li,
>> +				pr_info(" %d:%dx%d", li,
> 
> pr_cont
> 
>>  					mini2440_lcd_cfg[li].width,
>>  					mini2440_lcd_cfg[li].height);
>> -		printk("\n");
>> +		pr_info("\n");
> 
> pr_cont
> 
> So only the first printk should use pr_info().
> The subsequent printk uses should use pr_cont()

at this point, I don't know what to do.

Should I resubmit the patches? Or is it in the hands of
Krzysztof (krzk at kernel.org)? I would say a git rebase -i
is enough to edit the patch and this rebase is obviously
not to be done by me, but I don't know the process.

Regards,
C?dric.



> 
>>  		s3c24xx_fb_set_platdata(&mini2440_fb_info);
>>  	}
>>  
