From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 19 Dec 2013 20:41:23 +0100
Subject: [PATCH v3 1/2] clk: add clk accuracy retrieval support
In-Reply-To: <20131219193633.18119.57678@quantum>
References: <1387290983-6236-1-git-send-email-b.brezillon@overkiz.com>
 <1387290983-6236-2-git-send-email-b.brezillon@overkiz.com>
 <20131219060431.18119.64699@quantum> <52B2B42F.9010202@overkiz.com>
 <20131219193633.18119.57678@quantum>
Message-ID: <52B34BE3.7000208@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/12/2013 20:36, Mike Turquette a ?crit :
> Quoting boris brezillon (2013-12-19 00:54:07)
>> Hello Mike,
>>
>> On 19/12/2013 07:04, Mike Turquette wrote:
>>> Quoting Boris BREZILLON (2013-12-17 06:36:22)
>>>> +unsigned long __clk_get_accuracy(struct clk *clk)
>>>> +{
>>>> +       unsigned long ret;
>>>> +
>>>> +       if (!clk)
>>>> +               return 0;
>>>> +
>>>> +       return clk->accuracy;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(__clk_get_accuracy);
>>> Any reason for exporting this?
>> This might be used by clk drivers to choose the most accurate clk
>> among its parent clks (within the determinate_rate callback).
>>
>> And as some clk drivers might be compiled as modules we need
>> to export the symbol (__clk_get_name helper function is exported
>> too).
> Does your driver need this or is this just following the existing
> __clk_get_rate / clk_get_rate model?

No, I don't need this for my driver, at least for the moment.

Do you want me to drop this EXPORT_SYMBOL ?
>
> Regards,
> Mike
>
>> Best Regards,
>>
>> Boris
>>> Regards,
>>> Mike
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
