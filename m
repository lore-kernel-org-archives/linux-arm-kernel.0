From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 25 Mar 2013 22:20:30 +0530
Subject: [PATCH 1/2] cpufreq: Notify all policy->cpus in
 cpufreq_notify_transition()
In-Reply-To: <51507FEA.8040306@wwwdotorg.org>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
 <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
 <51507FEA.8040306@wwwdotorg.org>
Message-ID: <CAKohpokSmEYbW0YRasAg3MV16B3Bo8uYDqc0jLJhgR8VfbSVUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2013 22:18, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/24/2013 11:19 PM, Viresh Kumar wrote:
>> On 24 March 2013 19:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> policy->cpus contains all online cpus that have single shared clock line. And
>>> their frequencies are always updated together.
>>>
>>> Many SMP system's cpufreq drivers take care of this in individual drivers but
>>> the best place for this code is in cpufreq core.
>>>
>>> This patch modifies cpufreq_notify_transition() to notify frequency change for
>>> all cpus in policy->cpus and hence updates all users of this API.
>>
>> Another fixup for tegra:
>
> This series including this patch (although I had a devil of a time
> applying this fixup since all the TABs got converted to spaces when it
> was pasted into email)

So sorry for that, I keep pushing them here:

http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/cpufreq-fix-notify
