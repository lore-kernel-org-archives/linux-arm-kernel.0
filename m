From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 04 Feb 2014 00:49:40 +0800
Subject: a LLC sched domain bug for panda board?
In-Reply-To: <CAKfTPtDJ267W9UMRj-pgyha0yf1L-VWBMKgi+QdVEA4zFJYXLw@mail.gmail.com>
References: <52EFC11A.8010709@linaro.org>
 <CAKfTPtDD9g6PPx=cDkbH2VDO0k1HDAjcxwxeW2YLXwL5T4d6NA@mail.gmail.com>
 <CAKfTPtDJ267W9UMRj-pgyha0yf1L-VWBMKgi+QdVEA4zFJYXLw@mail.gmail.com>
Message-ID: <52EFC8A4.2060906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 12:28 AM, Vincent Guittot wrote:
> On 3 February 2014 17:27, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>> Have you checked that CONFIG_SCHED_LC is set ?
> 
> sorry it's CONFIG_SCHED_MC

Thanks for reminder! no it wasn't set. Does it means
arch/arm/configs/omap2plus_defconfig need add this config?

> 
>>
>>
>> On 3 February 2014 17:17, Alex Shi <alex.shi@linaro.org> wrote:
>>> I just run the 3.14-rc1 kernel on panda board. The only domain for it is
>>> 'CPU' domain, but this domain has no SD_SHARE_PKG_RESOURCES setting, it
>>> has no sd_llc.
>>>
>>> Guess the right domain for this board should be MC. So is it a bug?
>>>
>>> ..
>>> /proc/sys/kernel/sched_domain/cpu0/domain0/name:CPU
>>> ..
>>> /proc/sys/kernel/sched_domain/cpu1/domain0/name:CPU
>>>
>>> --
>>> Thanks
>>>     Alex
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Thanks
    Alex
