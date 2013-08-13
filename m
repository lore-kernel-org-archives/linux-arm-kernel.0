From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 13 Aug 2013 07:59:39 -0700
Subject: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <CA+Bv8Xb8cy-=ESE4nWOCub=aw7KFrOgEgzfdGUd1TqDJ0ZR_Gg@mail.gmail.com>
 (Russ Dill's message of "Tue, 13 Aug 2013 00:43:09 -0700")
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
 <CA+Bv8Xb8cy-=ESE4nWOCub=aw7KFrOgEgzfdGUd1TqDJ0ZR_Gg@mail.gmail.com>
Message-ID: <87zjslocv8.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russ Dill <russ.dill@gmail.com> writes:

> On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:

[...]

>> +static int wkup_m3_probe(struct platform_device *pdev)
>> +{
>> +       int irq, ret = 0;
>> +       struct resource *mem;
>> +
>> +       pm_runtime_enable(&pdev->dev);
>> +
>> +       ret = pm_runtime_get_sync(&pdev->dev);
>> +       if (IS_ERR_VALUE(ret)) {
>> +               dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
>> +               return ret;
>> +       }
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (!irq) {
>> +               dev_err(wkup_m3->dev, "no irq resource\n");
>
> &pdev->dev
>
>> +               ret = -ENXIO;
>> +               goto err;
>> +       }
>> +
>> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!mem) {
>> +               dev_err(wkup_m3->dev, "no memory resource\n");
>
> &pdev->dev

For future reference, when reviewing, please trim to only relevant
content/context, especially on large patches so maintainers/reviewers do
not have to find 2 one-line comments in a huge amount of irrelevant
context.

Thanks,

Kevin
