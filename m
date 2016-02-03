From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 4 Feb 2016 01:57:23 +0800
Subject: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <56B23D61.2050001@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
 <56B23D61.2050001@codeaurora.org>
Message-ID: <CADyBb7tteV7VF9oxMaq5NprVdS2UBKobupxoyfSp+jQwp5wmQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 4 February 2016 at 01:48, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei at linaro.org wrote:
>>
>> +static struct platform_driver sbsa_gwdt_driver = {
>> +       .driver = {
>> +               .name = "sbsa-gwdt",
>> +               .pm = &sbsa_gwdt_pm_ops,
>> +               .of_match_table = sbsa_gwdt_of_match,
>> +       },
>> +       .probe = sbsa_gwdt_probe,
>> +       .remove = sbsa_gwdt_remove,
>> +       .shutdown = sbsa_gwdt_shutdown,
>> +       .id_table = sbsa_gwdt_pdev_match,
>> +};
>
>
> I just noticed you dropped ACPI support.  Server platforms are supposed to
> use ACPI, so that seems like a critical omission to me.  You had a GTDT
> parser in an older version of this patch.  What happened to it?

I have posted  GTDT support separately : https://lkml.org/lkml/2016/2/1/660

devicetree driver and GTDT driver both export sbsa gwdt info to
"platform resource".

this driver get hardware info from platform resource.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
