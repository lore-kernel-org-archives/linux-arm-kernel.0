From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 15 Nov 2016 20:59:39 +0200
Subject: [PATCH 02/16] ARM: EXYNOS: use generic API to enable SCU
In-Reply-To: <1479099731-28108-3-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161115185939.GA14626@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 10:31:57AM +0530, Pankaj Dubey wrote:
> Now as we have of_scu_enable which takes care of mapping
> scu base from DT, lets use it.
> 
> This patch also fixes build failure in case !SMP caused
> by commit SHA ID: 94210b1abb2 which is already merged in
> krzk/for-next branch
> 
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h  |  1 -
>  arch/arm/mach-exynos/platsmp.c | 30 ++++--------------------------
>  arch/arm/mach-exynos/pm.c      |  4 ++--
>  arch/arm/mach-exynos/suspend.c | 14 ++++----------
>  4 files changed, 10 insertions(+), 39 deletions(-)
> 

Looks correct, for reference:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

However this depends on changes in my next/soc branch (and these changes
were the trigger for this patchset). I can either provide a tag with
Exynos commits or accept one with common SCU code.

Best regards,
Krzysztof
