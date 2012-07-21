From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 21 Jul 2012 10:34:29 +0530
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <CAJOA=zMQKLTumW7Nx68+yxHC5Yk4QyiL2mf1+TSZfVOAtnXDWA@mail.gmail.com>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <CAMQu2gw32LogXJJa+K5ZjmCZzBNK3FY2wYwZXU8fsftsVzEO2Q@mail.gmail.com>
 <20120720123317.GA32263@S2101-09.ap.freescale.net>
 <CAJOA=zMQKLTumW7Nx68+yxHC5Yk4QyiL2mf1+TSZfVOAtnXDWA@mail.gmail.com>
Message-ID: <CAMQu2gy4p+rL-sDAsGCnqSn_2eXwSqf---OS0BSXuDoacjd6_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 9:20 PM, Turquette, Mike <mturquette@ti.com> wrote:
> On Fri, Jul 20, 2012 at 5:33 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Fri, Jul 20, 2012 at 12:22:14PM +0530, Shilimkar, Santosh wrote:
>>> This *_CPU0 doesn't seems to be appropriate since this infrastructure will be
>>> used on SMP systems where CPUs shares clock/voltage rails. May be you can
>>> get rid of that unless there is a strong need.
>>>
>> All the resource handlers, clk, regulator, opp, DT node, are retrieved
>> from CPU0 device even for SMP.  I hope the naming of the driver could
>> tell:
>>
>> - The driver supports UP
>> - The driver supports SMP where CPUs shares clock/voltage rails by
>>   managing CPU0 (resource)
>> - The driver does not support SMP where individual CPU can scale
>>   clock/voltage independently.
>>
>
> How about cpufreq-single-thread.c and CONFIG_CPUFREQ_SINGLE_THREAD?
> That makes sense for both UP and SMP.
>
Indeed. This sounds more appropriate and also reflects what actually happens
with a UP or shared clock SMP case.

Regards
Santosh
