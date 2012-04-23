From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 23 Apr 2012 11:17:29 +0200
Subject: [PATCH] ARM: ux500: add the cpuidle driver for WFI and ARM
 retention
In-Reply-To: <4F950B85.2010505@stericsson.com>
References: <1334839592-32251-1-git-send-email-daniel.lezcano@linaro.org>
 <4F950B85.2010505@stericsson.com>
Message-ID: <4F951E29.6060009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2012 09:57 AM, Rickard Andersson wrote:
> Should not the driver be located in the 'drivers/cpuidle/' directory?

We had a discussion about moving the cpuidle drivers to this directory 
but there are too much dependencies between the arch specific code and 
the drivers and Russell thinks there is no real benefit of moving these 
drivers out arch/arm.

http://www.spinics.net/lists/arm-kernel/msg155454.html

The discussion is at91 specific but as this work was part of moving the 
drivers to the 'drivers' directory in general. I assumed the same rule 
applied to the ux500 cpuidle driver.

The current driver has the WFI and the ApIdle states and could be moved 
to drivers directory without complicating the dependencies but that 
won't be consistent with the rest of the drivers location (not only ARM) 
and I am not sure that will be still the case with the next states 
'ApSleep' and 'ApDeepSleep'.

IMO we should put this driver in arch/arm/mach-ux500, and, in the 
future, if we are able to move all the SoC cpuidle drivers to the 
'drivers' directory then this driver will be moved too.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
