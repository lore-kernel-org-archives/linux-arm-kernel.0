From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Apr 2014 09:29:36 +0100
Subject: [PATCH 07/10] ARM: bcm: tidy up a few includes
In-Reply-To: <1397788215-20279-8-git-send-email-elder@linaro.org>
References: <1397788215-20279-1-git-send-email-elder@linaro.org>
 <1397788215-20279-8-git-send-email-elder@linaro.org>
Message-ID: <20140418082936.GA24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 09:30:12PM -0500, Alex Elder wrote:
> Clean up a few header file includes, eliminating a few that are not
> really needed and putting in their place some that are.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Matt Porter <mporter@linaro.org>
> ---
>  arch/arm/mach-bcm/board_bcm21664.c |    3 +--
>  arch/arm/mach-bcm/kona.c           |    5 +++--
>  arch/arm/mach-bcm/kona.h           |    1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm/board_bcm21664.c b/arch/arm/mach-bcm/board_bcm21664.c
> index acc1573..ab96c3f 100644
> --- a/arch/arm/mach-bcm/board_bcm21664.c
> +++ b/arch/arm/mach-bcm/board_bcm21664.c
> @@ -11,13 +11,12 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/clocksource.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  
>  #include <asm/mach/arch.h>
> +#include <asm/io.h>

It's linux/io.h

> diff --git a/arch/arm/mach-bcm/kona.h b/arch/arm/mach-bcm/kona.h
> index 110185f..bcdcf06 100644
> --- a/arch/arm/mach-bcm/kona.h
> +++ b/arch/arm/mach-bcm/kona.h
> @@ -12,6 +12,7 @@
>   */
>  
>  #ifdef CONFIG_ARCH_BCM_MOBILE_L2_CACHE
> +#include <linux/init.h>
>  
>  void __init kona_l2_cache_init(void);

Just get rid of the __init instead.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
