From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 14 Mar 2014 14:32:29 -0500
Subject: [RFC] cpufreq-cpu0: allow OPP table supplied by platform
In-Reply-To: <532321FB.7080106@ti.com>
References: <20140313184859.7d6f6512@xhacker>
 <CAKohpokLv0m+Cky7nCUOgP-djTMrA6jyka_EZ07+_exCAexXXg@mail.gmail.com>
 <CAKohpoke1i8xmKProgF+ki7Q=Q+YxbPnewdtbyPqu7857DLLWA@mail.gmail.com>
 <20140313194424.122ec572@xhacker>
 <20140314123205.GC813@S2101-09.ap.freescale.net> <532321FB.7080106@ti.com>
Message-ID: <5323594D.30406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2014 10:36 AM, Nishanth Menon wrote:
> On 03/14/2014 07:32 AM, Shawn Guo wrote:
>> On Thu, Mar 13, 2014 at 07:44:24PM +0800, Jisheng Zhang wrote:
>>>> On 13 March 2014 16:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>> On 13 March 2014 16:18, Jisheng Zhang <jszhang@marvell.com> wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> cpufreq-cpu0 is suitable for Marvell Berlin SoC. But there's one issue
>>>>>> to address. The opp is different between chips even on the same step
>>>>>> SoC, BG2Q for example. we can calculate the OPP table from the value of
>>>>>> one OTP register. We have two solutions:
>>>>>>
>>>>>> 1. bootloader reads OTP register and calculate the OPP table then change
>>>>>> dtb danamically
>>>>>>
>>>>>> 2. supply one driver in mach-berlin to initialize the OPP table; and
>>>>>> modify cpufreq-cpu0 to allow platform supply OPP table, fall back to
>>>>>> of_init_opp_table() if there's no OPP table.
>>>>>>
>>>>>> Which solution is better?
>>>>>
>>>>> I think we can go ahead with second option here. We can just check if opp
>>>>> tables are already initialized or not. In case they are, don't probe from
>>>>> dt..
>>>>>
>>>>> But lets see with others have to say here..
>>
>> Yea, we had gone for the second option on imx6q-cpufreq driver with
>> commit 20b7cbe (cpufreq: imx6q: add of_init_opp_table).
>
> There might be a better alternative here given the scope of potential
> reuse cross SoCs - a generic opp modifier logic which'd work for all
> of us. I will let Dave Gerlach post his series to give an idea.

I have posted an RFC for a small opp-modifier framework along with a 
driver that uses it to enable or disable OPPs based on a register value. 
I copied everyone from this thread but in case I forgot anyone the 
series is here http://marc.info/?l=linux-pm&m=139482524506817&w=2.

Regards,
Dave

>
