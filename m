From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 16 Dec 2014 09:07:28 +0530
Subject: 3.18: lockdep problems in cpufreq
In-Reply-To: <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <7573578.UE8ufgjWuX@vostro.rjw.lan>
 <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
 <002f01d0186b$2700b730$75022590$%brar@samsung.com>
 <20141215134636.GI11285@n2100.arm.linux.org.uk>
 <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
Message-ID: <CAKohpokfG3wH=p=mzz4Owa7yqrirM_Djfc-xZFaAOKZwq1GfZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 December 2014 at 20:24, Yadwinder Singh Brar
<yadi.brar@samsung.com> wrote:
>> Unfortunately, you do need some kind of synchronisation here.  If it's
>> not important when cpufreq_register_notifier() gets called, maybe this
>> can work:
>>
>>       bool register;
>>
>>       mutex_lock(&cooling_cpufreq_lock);
>>       register = cpufreq_dev_count++ == 0;
>>       list_add(&cpufreq_dev->node, &cpufreq_dev_list);
>>       mutex_unlock(&cooling_cpufreq_lock);
>>
>>       if (register)
>
> register may be 0 in scenario you stated above in second point.
> So this approach will not work.

I didn't understood what you meant here. register will be zero only
for one of the threads.
