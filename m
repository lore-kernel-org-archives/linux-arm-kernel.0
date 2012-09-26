From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Sep 2012 11:11:40 -0500
Subject: [PATCH V2 7/7] ARM: OMAP: Add DT support for timer driver
In-Reply-To: <50632497.2070103@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <1347579091-3794-8-git-send-email-jon-hunter@ti.com>
 <50632497.2070103@ti.com>
Message-ID: <5063293C.1080404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 10:51 AM, Jon Hunter wrote:
> Hi Rob,



>>  #define OMAP3_32K_SOURCE	"omap_32k_fck"
>>  #define OMAP4_32K_SOURCE	"sys_32k_ck"
>>  
>> +#define TIMER_PROP_ALWON	"ti,timer-alwon"
>> +
> 
> I see you made the following comment [1] here ...
> 
> "It would be easier to follow the code if you use the strings directly
> (and you do in some places)."
> 
> I could avoid the above definition.
> 
>>  #ifdef CONFIG_OMAP_32K_TIMER
>>  #define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
>>  #define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
>>  #define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
>>  #define OMAP3_SECURE_TIMER	12
>> +#define TIMER_PROP_SECURE	"ti,timer-secure"
>>  #else
>>  #define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
>>  #define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
>>  #define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
>>  #define OMAP3_SECURE_TIMER	1
>> +#define TIMER_PROP_SECURE	TIMER_PROP_ALWON
>>  #endif
> 
> Are you ok, with having the TIMER_PROP_SECURE definition or would you
> prefer I handle this differently? This is dependent on the kernel config.\

Yes, that's fine.

Rob

> 
> Cheers
> Jon
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/84458/focus=84982
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
