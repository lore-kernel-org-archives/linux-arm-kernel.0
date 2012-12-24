From: linuxzsc@gmail.com (Richard Zhao)
Date: Mon, 24 Dec 2012 10:26:25 +0800
Subject: [PATCH] ARM: tegra: cpufreq: move clk_get/put out of function
 tegra_cpu_init/exit
In-Reply-To: <50D6DE6E.4060106@nvidia.com>
References: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
 <50D4D44F.2080203@wwwdotorg.org> <50D6DE6E.4060106@nvidia.com>
Message-ID: <CANg6MZjXWLJdnZiaJ=7=ONLoyyhWHAofnHZ7CZCDR06vER7ZDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 23, 2012 at 6:35 PM, Prashant Gaikwad <pgaikwad@nvidia.com> wrote:
> On Saturday 22 December 2012 02:57 AM, Stephen Warren wrote:
>>
>> On 12/21/2012 03:09 AM, Richard Zhao wrote:
>>>
>>> tegra_cpu_init/exit will be called every time one cpu core is online or
>>> offline. And all cpu cores share same clocks, redundant clk_get/put
>>> wast time,  so I move them out.
>>
>> I think this is reasonable.
>>
>> Prashant, Peter, any comments?
>>
>> Is any other work in tegra_cpu_init() redundant? Is tegra_cpu_init()
>> supposed to be called due to hotplug, or is that a bug in the cpufreq
>> core?
When cpu goes offline, kernel don't know whether it'll come back.
Sounds reasonable.
>
>
> Looks good. Also, instead of array we can use single variable for
> target_cpu_speed.
I think yes. If one day the cores support rate changing independently,
we can create another driver. It supposed to be another patch to do it.

Thanks
Richard
