From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 8 May 2015 08:07:39 -0600
Subject: [PATCH 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <CACRpkdak5-iuWEDAvhDq3uwYobK+tW_N-t-QaY+-5TUSCa7uOg@mail.gmail.com>
References: <1429742451-11465-1-git-send-email-mathieu.poirier@linaro.org>
 <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
 <CACRpkdak5-iuWEDAvhDq3uwYobK+tW_N-t-QaY+-5TUSCa7uOg@mail.gmail.com>
Message-ID: <CANLsYkwT9zinP6KLi6o95+fGwPbxbUgWTpMnL7yZfsfTU8p31A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2015 at 06:28, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Apr 23, 2015 at 12:40 AM, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>
>> From: Pratik Patel <pratikp@codeaurora.org>
>>
>> This driver manages the CoreSight ETMv4 (Embedded Trace Macrocell) IP block
>> to support HW assisted tracing on ARMv7 and ARMv8 architectures.
>>
>> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
>> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> (...)
>> +/* The number of ETMv4 currently registered */
>> +static int etm4_count;
>> +static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
>
> Don't you need a mutex or something around etm4_count so
> as to protect it? You could also make it an atomic.

Sorry for the late reply, your email got lost under the pile.

The etm4_count is only used at boot time to avoid registering the
notifiers twice and not used otherwise.  Since the discovery of
coresight devices is sequential there is no point in guarding it.

>
> Also why is it a signed int ... unsigned int?
>
> I know, lame comments, the runtime PM stuff looks perfect now,

I like it too - thanks for the review.

> someone had a refcount comment but it's doing the right thing.
>
> Yours,
> Linus Walleij
