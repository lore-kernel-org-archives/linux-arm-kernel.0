From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Jan 2016 09:48:20 +0900
Subject: [PATCH 0/8] rtc: max77686: Extend driver and add max77802 support
In-Reply-To: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
Message-ID: <56A02AD4.40107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.01.2016 02:14, Javier Martinez Canillas wrote:
> Hello,
> 
> On a recent disussion [0] with Krzysztof Kozlowski and Laxman Dewangan,
> we came to the conclusion that the max77686 and max77802 RTC are almost
> the same with only a few differences so there shouldn't be two separate
> drivers and is better to extend max77686 driver and delete rtc-max77802.
> 
> By making the driver more generic, other RTC IP blocks from Maxim PMICs
> could be supported as well like the max77620.
> 
> Patches #1 is just a trivial cleanup.
> 
> Patch #2 allows to support RTCs that need a shorter delay when updating
> the RTC.
> 
> Patch #3 adds a driver data structure to avoid hard-coding parameters
> specific to a certain RTC such as the needed delay and RTC register mask.
> 
> Patch #4 changes the driver to use a mapping table instead of using the
> max77686 registers offsets directly to allow supporting RTC with other
> registers addresses and layout.
> 
> Patch #5 Adds support for max77802 to max77686 RTC driver and patch #6
> removes the old driver since is not needed anymore.
> 
> Finally patch #7 and patch #8 removes the Kconfig symbol from defconfigs.
> 
> I've tested this patch-set on an Exynos5800 Peach Pi Chromebook that has
> a max77802 PMIC and the RTC was working correctly but I don't have a
> machine with max77686 so I will really appreaciate if someone can test
> that no regressions were introduced.
> 

Thanks for the submission. I like the approach. I'll start reviewing the
code and testing it... or maybe I'll wait with testing for v2 because I
already sent some comments. :)

Anyway I will provide later tested-by on max77686.

Best regards,
Krzysztof
