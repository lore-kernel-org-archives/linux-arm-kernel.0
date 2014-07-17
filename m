From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 17 Jul 2014 11:05:14 +0530
Subject: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <53C6D8EC.1030609@codeaurora.org>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
 <1405464473-3916-2-git-send-email-skannan@codeaurora.org>
 <CAKohpok2hzwDLy77CZJ+7pHV-Nj4XTviJxVeXQYJRYtKXME00w@mail.gmail.com>
 <53C65F03.1050609@mit.edu> <53C6D8EC.1030609@codeaurora.org>
Message-ID: <CAKohpongsNtEVbHL=w1fbw5tEXK=WaMcp1N03ar9Sx_CU=1O-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2014 01:26, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 07/16/2014 04:16 AM, Srivatsa S. Bhat wrote:

>> That is, we wanted
>> to do the kobject cleanup after releasing the hotplug lock, and POST_DEAD
>> stage was well-suited for that.

I think, this has changed in Saravana's patch, we do it in the PREPARE stage
now.

>> Commit 1aee40ac9c8 (cpufreq: Invoke __cpufreq_remove_dev_finish() after
>> releasing cpu_hotplug.lock) explains this in detail. Saravana, please take
>> a
>> look at that reasoning and ensure that your patch doesn't re-introduce
>> those
>> deadlock possibilities!
>
>
> But all of that was needed _because_ we were creating and destroying
> policies and kobjs all the time. We don't do that anymore. So, I don't think
> any of that applies. We only destroy when the cpufreq driver is
> unregistered. That's kinda of the point of this patchset.
>
> Thoughts?

See above.
