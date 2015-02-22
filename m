From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 23 Feb 2015 08:44:18 +0900
Subject: [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency
 driver
In-Reply-To: <54E4FD40.8020206@gmx.net>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
 <54DFE797.1020008@math.uni-bielefeld.de> <54E4FD40.8020206@gmx.net>
Message-ID: <54EA69D2.7010706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tobias,

First of all, thanks for your test.

On 02/19/2015 05:59 AM, Tobias Jakobi wrote:
> Hello again,
> 
> Tobias Jakobi wrote
>> I've tested the series on my Odroid-X2 (by adapting the TRATS2 changes),
>> and so far I haven't seen any issues. With the system being idle one can
>> see that the 'simple_ondemand' devfreq governor clocks down both memory
>> busses to the lowest state.
> 
> looks I was too hasty the last time. Actually this series breaks HDMI
> output for me (or at least with 'simple_ondemand' governor, haven't
> tried with performance yet).
> 
> I tried to run some simple application, but it hangs in uninterruptible
> sleep immediately, probably before the first page flip. Going to check
> this more thoroughly.
> 
> Maybe some parts of the hdmi subsystem don't like the lower clocks?

As you thought, when maintaining lower clock of memory bus frequency,
some issue related to multimedia feature will happen.

Separately, We have to check the miminum lower clock for working of multimedia feature.
and then multimedia or other IP have to request it to DVFS driver (memory busfreq driver).
But, latest mainline kernel currently has not some way to inform minimum clock to DVFS driver.

So, If you check the miminum clock for hdmi, I'll use this clock as minumu frequency of dvfs table.

Thanks,
Chanwoo Choi
