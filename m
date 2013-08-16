From: lantianyu1986@gmail.com (Lan Tianyu)
Date: Fri, 16 Aug 2013 23:30:56 +0800
Subject: [PATCH 02/34] cpufreq: acpi: remove calls to
 cpufreq_notify_transition()
In-Reply-To: <CAKohpom7yk3Zq5JABZ6T+Z_AcMn5G1hoswZK8T=viYv0fp0mcg@mail.gmail.com>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
 <333bf5868dfbfb6de474f060dc216fa6d33848e2.1376619363.git.viresh.kumar@linaro.org>
 <CAOLK0pz7e8nQVnZY0a-j_Fd_kFOqF8ZS4tRfYw1S+25Lv8GoFQ@mail.gmail.com>
 <CAOLK0pyVDSc6x1u8Ro6ng1dH8ELqc3P9jPHamgiXBn6sWDgm8w@mail.gmail.com>
 <CAKohpom7yk3Zq5JABZ6T+Z_AcMn5G1hoswZK8T=viYv0fp0mcg@mail.gmail.com>
Message-ID: <CAOLK0py25j2g+X0rCzDjxvFac1ZZcOS0y_sehTFYYwkz8FrUHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/16 Viresh Kumar <viresh.kumar@linaro.org>:
> On 16 August 2013 13:24, Lan Tianyu <lantianyu1986@gmail.com> wrote:
>> Sorry for misoperation.
>
> No Problem...
>
>>                 One concern. Target() callback may return before changing
>> cpufreq actually due to some check failures. After this change, prechange
>> event will be triggered when these check failures take place. I am not sure
>> whether this should be took into account.
>
> Yes, if you see the first patch of this series, it takes this into
> account.. In case
> target() failed and returned an error, we simply notify the POST CHANGE
> notification with old frequencies instead of new ones. I believe that would be
> enough..

Yes, I have seen it but I missed the following two patches because they
are not in the linux-pm tree. You moved the cpufreq_frequency_table_target()
to cpufreq core and before notifying PRE CHANGE notification. The major
check has been done. Now I think it's ok. Thanks for explanation.

http://www.spinics.net/lists/cpufreq/msg06970.html
http://www.spinics.net/lists/cpufreq/msg06896.html

Reviewed-by: Lan Tianyu <tianyu.lan@intel.com>

>
> This is exactly what acpi-cpufreq and others are doing currently.
>
> Hope I answered your question well?
>
> --
> viresh



-- 
Best regards
Tianyu Lan
