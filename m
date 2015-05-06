From: Dave.Martin@arm.com (Dave P Martin)
Date: Wed, 6 May 2015 13:05:05 +0100
Subject: [PATCH 0/5] Second round of MCPM refactoring
In-Reply-To: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20150506120504.GD3870@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 05:06:27PM +0100, Nicolas Pitre wrote:
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

Good stuff.

FWIW: except for the hip04 patch which I'll leave to the relevant
maintainer,

Acked-by: Dave Martin <Dave.Martin@arm.com>

I have not reviewed this stuff in detail, but it looks like sensible
cleanup to me.

Cheers
---Dave

> 
>  arch/arm/common/mcpm_entry.c         | 281 +++++++++++++----------------
>  arch/arm/include/asm/mcpm.h          |  73 +++-----
>  arch/arm/mach-exynos/suspend.c       |   8 +-
>  arch/arm/mach-hisi/platmcpm.c        | 127 +++++--------
>  drivers/cpuidle/cpuidle-big_little.c |   8 +-
>  5 files changed, 198 insertions(+), 299 deletions(-)
> 
