From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 11 Feb 2015 13:34:26 +0900
Subject: [PATCH V4 3/4] mmc: pwrseq: Initial support for the simple MMC
 power sequence provider
In-Reply-To: <CAPDyKFrdpknrMa62Vz4dfKaFMTdF-uXaAz3pkw_3qwNvHy49SQ@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-4-git-send-email-ulf.hansson@linaro.org>
 <CAAVeFu+ubZZGQd=zPPYm--PVCO9q-A3503Y5g50+sU4ztxU+iA@mail.gmail.com>
 <CAPDyKFrdpknrMa62Vz4dfKaFMTdF-uXaAz3pkw_3qwNvHy49SQ@mail.gmail.com>
Message-ID: <CAAVeFuLQkNz6x21w8xCM==nwyt0QbYL_uPC9+TdRCj2w+FVu1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 1:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>> +int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>>> +{
>>> +       struct mmc_pwrseq_simple *pwrseq;
>>> +
>>> +       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>>> +       if (!pwrseq)
>>> +               return -ENOMEM;
>>> +
>>> +       pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>>> +       host->pwrseq = &pwrseq->pwrseq;
>>
>> How about making this function return a struct mmc_pwrseq * so this
>> last line can be moved to mmc_pwrseq_alloc() instead of requiring all
>> power sequences to do it?
>>
>> The same applies to
>>
>>     host->pwrseq = NULL;
>>
>> in mmc_pwrseq_simple_free(), which could be done in mmc_pwrseq_free() it seems.
>
> Thanks for reviewing!
>
> I like you suggestion, though $subject patch is already part of the PR for 3.20.
>
> Feel free to send a patch, I would happily apply it.

Damn, why am I always so late to review patches...

I will send a fixup patch - better to have this done early.

Thanks!
