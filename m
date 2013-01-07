From: mikedunn@newsguy.com (Mike Dunn)
Date: Mon, 07 Jan 2013 05:40:15 -0800
Subject: [PATCH 2/4] ALSA: pxa27x: fix ac97 warm reset bug work-around code
In-Reply-To: <50EA9607.7050408@compulab.co.il>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-3-git-send-email-mikedunn@newsguy.com>
 <50EA9607.7050408@compulab.co.il>
Message-ID: <50EAD03F.4050507@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2013 01:31 AM, Igor Grinberg wrote:
> On 01/06/13 21:13, Mike Dunn wrote:


[..]


>> diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
>> index a611ad3..8281e17 100644
>> --- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
>> +++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
>> @@ -463,6 +463,9 @@
>>  	GPIO76_LCD_PCLK,	\
>>  	GPIO77_LCD_BIAS
>>  
>> +/* these enable a work-around for a hw bug in pxa27x during ac97 warm reset */
>> +#define GPIO113_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO113, AF0, DRIVE_HIGH)
>> +#define GPIO95_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO95, AF0, DRIVE_HIGH)
> 
> Do we really need to change the LPM? Because DRIVE_* only affect LPM.


Oops, no, we don't.  In fact, since you pointed this out to me in your review of
the earlier patch, I meant to remove it.  It does no harm, but should be removed
for clarity.

Thanks,
Mike
