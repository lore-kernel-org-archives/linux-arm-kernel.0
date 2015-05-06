From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 6 May 2015 12:03:05 +0100
Subject: [PATCH 0/5] Second round of MCPM refactoring
In-Reply-To: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <5549F4E9.9030303@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/1/2015 5:06 PM, Nicolas Pitre wrote:
> This is the sequel to the first episode that started here:
> 
> 	http://article.gmane.org/gmane.linux.ports.arm.kernel/401353
> 
> Now that most of the first set has been merged upstream, here's the last
> set to complete the cleanup. This mainly includes the removal of the
> backward compatibility support plus some cosmetic changes.
> 
> The hisi04 backend, though, is instead converted to raw SMP operations
> as it currently doesn't benefit from MCPM at all and doesn't fit well
> with the new backend structure.
> 
> This series can also be obtained from the following Git repository:
> 
> 	http://git.linaro.org/people/nicolas.pitre/linux.git mcpm
> 
> The diffstat shows more code removal again:
> 
>  arch/arm/common/mcpm_entry.c         | 281 +++++++++++++----------------
>  arch/arm/include/asm/mcpm.h          |  73 +++-----
>  arch/arm/mach-exynos/suspend.c       |   8 +-
>  arch/arm/mach-hisi/platmcpm.c        | 127 +++++--------
>  drivers/cpuidle/cpuidle-big_little.c |   8 +-
>  5 files changed, 198 insertions(+), 299 deletions(-)
> 
> .
> 

Tested by: Wei Xu <xuwei5@hisilicon.com>

Built and booted all the 16 cores on D01 board based on v4.1-rc2.
And confirmed CPU hotplug works well on D01 board.

Thanks!

Best Regards,
Wei
