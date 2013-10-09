From: afzal@ti.com (Afzal Mohammed)
Date: Wed, 9 Oct 2013 12:52:47 +0530
Subject: [PATCH] ARM: OMAP2+: wakeupgen: AM43x adaptation
In-Reply-To: <20131008212436.GR8313@atomide.com>
References: <1378378535-2967-1-git-send-email-afzal@ti.com>
 <20131008212436.GR8313@atomide.com>
Message-ID: <52550447.5070805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wednesday 09 October 2013 02:54 AM, Tony Lindgren wrote:
> * Afzal Mohammed <afzal@ti.com> [130905 04:03]:

>> -#define MAX_NR_REG_BANKS	5
>> -#define MAX_IRQS		160
>> +/* maximum value correspond to that of AM43x */
>> +#define MAX_NR_REG_BANKS	7
>> +#define MAX_IRQS		224
>> +#define DEFAULT_NR_REG_BANKS	5
>> +#define DEFAULT_IRQS		160
>>  #define WKG_MASK_ALL		0x00000000
>>  #define WKG_UNMASK_ALL		0xffffffff
>>  #define CPU_ENA_OFFSET		0x400
> 
> How about define it like this to avoid updating things
> in multiple places for new SoCs:
> 
> #define AM43X_NR_REG_BANKS	7
> #define MAX_NR_REG_BANKS	AM43X_NR_REG_BANKS

Yes that is better

>>  	for (i = 0; i < irq_banks; i++) {
>>  		wakeupgen_writel(0, i, CPU0_ID);
>> -		wakeupgen_writel(0, i, CPU1_ID);
>> +		if (!am43x)
>> +			wakeupgen_writel(0, i, CPU1_ID);
>>  	}
> 
> Why not use soc_is_am43xx() directly here?

Ok, it has been changed in the new version.

Regards
Afzal
