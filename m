From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 21 Jul 2014 10:47:39 +0200
Subject: [GIT PULL 4/5] Samsung exynos_mct update for v3.17
In-Reply-To: <20140719220623.GF15676@quad.lixom.net>
References: <53C9C164.9030404@samsung.com>
 <20140719220623.GF15676@quad.lixom.net>
Message-ID: <53CCD3AB.7040205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2014 12:06 AM, Olof Johansson wrote:
> On Sat, Jul 19, 2014 at 09:52:52AM +0900, Kukjin Kim wrote:
>> Note that this is also based on 3.16-rc5 because of dependency with
>> previous samsung fixes including exynos_mct already merged in
>> mainline during -rc.
>>
>> The following changes since commit 1795cd9b3a91d4b5473c97f491d63892442212ab:
>>
>>    Linux 3.16-rc5 (2014-07-13 14:04:33 -0700)
>>
>> are available in the git repository at:
>>
>
>> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> tags/exynos-mct
>>
>> for you to fetch changes up to 1a631118c1d085fe162f3b6d44f710c72206ef2d:
>>
>>    clocksource: exynos_mct: Only use 32-bits where possible
>> (2014-07-19 03:07:52 +0900)
>>
>> ----------------------------------------------------------------
>> exynos_mct update for v3.17
>> - only use 32-bit access for performance benefits on exynos
>>    32-bit system and this means ARCH timer should be supported
>>    on exynos 64-bit system instead of current MCT.
>> - use readl_relaxed/writel_relaxed to consistently use the
>>    proper functions in exynos_mct.
>
> There's no reason for these to go through arm-soc, is there? They should
> go through the clocksource tree (Daniel Lezcano / Thomas Gleixner). They
> also lack acks from them if they for some reason need to go through arm-soc.

Yes, that's right. Furthermore I have been discussing with Doug about 
these patches before.

Kukjin, is there any dependency on these patches ?

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
