From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 18 Dec 2013 15:53:51 +0100
Subject: [PATCH v2 3/9] clocksource/cadence_ttc: Store timer frequency
 in driver data
In-Reply-To: <5cff3201-db97-4061-a686-bf79ac17d4fe@CO1EHSMHS006.ehs.local>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-4-git-send-email-soren.brinkmann@xilinx.com>
 <5cff3201-db97-4061-a686-bf79ac17d4fe@CO1EHSMHS006.ehs.local>
Message-ID: <52B1B6FF.7000400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2013 08:21 PM, S?ren Brinkmann wrote:
> Hi Daniel,
>
> On Tue, Nov 26, 2013 at 05:04:50PM -0800, Soren Brinkmann wrote:
>> It is not allowed to call clk_get_rate() from interrupt context. To
>> avoid such calls the timer input frequency is stored in the driver's
>> data struct which makes it accessible to the driver in any context.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> I doubt that we'll resolve all issues with this series before the
> holidays or even the next merge window. Could you take this patch into
> your tree for 3.14? It is not directly related to the cpufreq work and
> fixes an actual issue that triggers a kernel WARN under some condition
> (I missed preserving the details and the trace). That would take the
> easy stuff out of the way and we can focus on the more controversial
> changes.

You are asking to take it for 3.14 but shouldn't it go as a 3.13 fix ?

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
