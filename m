From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 18 Nov 2013 14:20:17 +0100
Subject: [RFC PATCH RESEND 1/2] clk: add clk accuracy retrieval support
In-Reply-To: <20131116015946.19193.29895@quantum>
References: <1381684631-10835-1-git-send-email-b.brezillon@overkiz.com>
 <1381684631-10835-2-git-send-email-b.brezillon@overkiz.com>
 <20131116015946.19193.29895@quantum>
Message-ID: <528A1411.6000905@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Nothing related to this thread, but if you have some time, could you 
take a look at
the last version (v5) of the at91 CCF port ?

I know Nicolas was planning to add this for 3.14, and we'd like to have 
your feedback
on the new dt bindings.

Best Regards,

Boris

On 16/11/2013 02:59, Mike Turquette wrote:
> Quoting Boris BREZILLON (2013-10-13 10:17:10)
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 73bdb69..942811d 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
> ...
>> @@ -194,6 +204,7 @@ struct clk_hw {
>>   struct clk_fixed_rate {
>>          struct          clk_hw hw;
>>          unsigned long   fixed_rate;
>> +       unsigned long   fixed_accuracy;
> This change belongs in patch #2. Please also update the kerneldoc above
> this struct definition.
>
> Regards,
> Mike
>
>>          u8              flags;
>>   };
>>   
>> diff --git a/include/linux/clk.h b/include/linux/clk.h
>> index 9a6d045..2fe3b54 100644
>> --- a/include/linux/clk.h
>> +++ b/include/linux/clk.h
>> @@ -85,6 +85,23 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
>>   #endif
>>   
>>   /**
>> + * clk_get_accuracy - obtain the clock accuracy in ppb (parts per billion)
>> + *                   for a clock source.
>> + * @clk: clock source
>> + *
>> + * This gets the clock source accuracy expressed in ppb.
>> + * A perfect clock returns 0.
>> + */
>> +#ifdef CONFIG_HAVE_CLK_GET_ACCURACY
>> +unsigned long clk_get_accuracy(struct clk *clk);
>> +#else
>> +static inline unsigned long clk_get_accuracy(struct clk *clk)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>> +/**
>>    * clk_prepare - prepare a clock source
>>    * @clk: clock source
>>    *
>> -- 
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
