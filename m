From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Sep 2017 14:18:08 +0530
Subject: [PATCH v4 1/2] i2c: davinci: Add PM Runtime Support
In-Reply-To: <CAMz4kuLGVes6a4iCF0VbG1ErWPR5at=HKgeGv3cMr1zv7aLzJg@mail.gmail.com>
References: <20170911201145.31257-1-fcooper@ti.com>
 <20170911201145.31257-2-fcooper@ti.com>
 <CAMz4kuLGVes6a4iCF0VbG1ErWPR5at=HKgeGv3cMr1zv7aLzJg@mail.gmail.com>
Message-ID: <021a99bb-3670-fff5-6835-b14d28827929@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 September 2017 07:28 AM, Baolin Wang wrote:
>> @@ -802,13 +821,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>         dev->clk = devm_clk_get(&pdev->dev, NULL);
>>         if (IS_ERR(dev->clk))
>>                 return PTR_ERR(dev->clk);
>> -       clk_prepare_enable(dev->clk);

> You removed clk enable here, I think it can not work if we did not
> open CONFIG_PM macro. I think you should keep clk enable here, and set

What do you mean by "open CONFIG_PM macro" ?

> rpm active by pm_runtime_set_active() before issuing
> pm_runtime_enable().

Can you explain why you want to do this instead of relying on
pm_runtime_get_sync() to enable clock?

Thanks,
Sekhar
