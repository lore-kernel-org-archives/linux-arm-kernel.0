From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Sep 2017 14:52:02 +0530
Subject: [PATCH v4 1/2] i2c: davinci: Add PM Runtime Support
In-Reply-To: <CAMz4ku+_saDS8VBf1kXb+HMDqvx2O2o4qwcU4dEjFvtyE_9JKg@mail.gmail.com>
References: <20170911201145.31257-1-fcooper@ti.com>
 <20170911201145.31257-2-fcooper@ti.com>
 <CAMz4kuLGVes6a4iCF0VbG1ErWPR5at=HKgeGv3cMr1zv7aLzJg@mail.gmail.com>
 <021a99bb-3670-fff5-6835-b14d28827929@ti.com>
 <CAMz4ku+_saDS8VBf1kXb+HMDqvx2O2o4qwcU4dEjFvtyE_9JKg@mail.gmail.com>
Message-ID: <d8ee0f47-fa69-3aca-6c5d-24f25505fa05@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 September 2017 02:44 PM, Baolin Wang wrote:
> Hi,
> 
> On 12 September 2017 at 16:48, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Tuesday 12 September 2017 07:28 AM, Baolin Wang wrote:
>>>> @@ -802,13 +821,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>>>         dev->clk = devm_clk_get(&pdev->dev, NULL);
>>>>         if (IS_ERR(dev->clk))
>>>>                 return PTR_ERR(dev->clk);
>>>> -       clk_prepare_enable(dev->clk);
>>
>>> You removed clk enable here, I think it can not work if we did not
>>> open CONFIG_PM macro. I think you should keep clk enable here, and set
>>
>> What do you mean by "open CONFIG_PM macro" ?
> 
> If you did not open CONFIG_PM macro, then the pm_runtime_xxx() will be
> dummy functions, but now the i2c driver can not work since you did not
> enable clock, right?

Ah, okay. I am not sure thats a concern on platforms on which this
driver is used. Without PM runtime support, most likely the platforms
will not boot and multiple drivers will fail.

Thanks,
Sekhar
