From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 2 Oct 2015 00:12:21 +0200
Subject: [RFC/PATCH 00/11] arm: omap: counter32k rework
In-Reply-To: <6944324.e1oo8C9xbx@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <20150930141338.GC31865@saruman.tx.rr.com> <3705422.OMk7ysE7Jn@wuerfel>
 <6944324.e1oo8C9xbx@wuerfel>
Message-ID: <560DAFC5.50003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2015 04:49 PM, Arnd Bergmann wrote:
> On Wednesday 30 September 2015 16:42:21 Arnd Bergmann wrote:
>>
>> TEGRA folks: the tegra_read_persistent_clock() implementation apparently
>> predates the Tegra RTC driver and I wonder if they actually do the
>> right thing in combination. Could it be that the wall time forwards
>> twice as fast as it should during resume when the RTC driver is loaded?
>> Could it be that we can simply remove  tegra_read_persistent_clock()
>> and the register_persistent_clock() infrastructure?
>>
>
> I found the 'sleeptime_injected' variable now, which takes care of
> forwarding the clock by the correct amount.
>
> I also found the CLOCK_SOURCE_SUSPEND_NONSTOP flag next to it, which
> should let us use the counter32k driver to provide the correct
> time during suspend without the omap_read_persistent_clock() function.
> We should be able to just delete that code.
>
> If we decide to also delete the tegra_read_persistent_clock()
> function, we can remove the registration too.


+1


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
