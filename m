From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Mon, 5 Mar 2018 10:18:56 +0100
Subject: [PATCH v2 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <20180302120026.52f34ad2@vmware.local.home>
References: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
 <20180301164343.5794-3-alexander.sverdlin@nokia.com>
 <20180302120026.52f34ad2@vmware.local.home>
Message-ID: <8aa72633-5323-7f85-d326-6b7231b12aeb@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steven!

On 02/03/18 18:00, Steven Rostedt wrote:
>> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
>> index 9e842ff..3e663f9 100644
>> --- a/arch/arm/include/asm/ftrace.h
>> +++ b/arch/arm/include/asm/ftrace.h
>> @@ -19,6 +19,7 @@ struct dyn_arch_ftrace {
>>  #ifdef CONFIG_OLD_MCOUNT
>>  	bool	old_mcount;
>>  #endif
> I think you want to add:
> 
> #ifdef CONFIG_ARM_MODULE_PLTS
>> +	struct module *mod;
> #endif
> 
> This will add more memory overhead, and we don't want to add that if it
> is not needed.

Will include it into the next version.
Thanks for the review!

-- 
Best regards,
Alexander Sverdlin.
