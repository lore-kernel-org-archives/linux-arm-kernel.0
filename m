From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 May 2013 10:47:44 +0900
Subject: [PATCH 09/20] ARM: shmobile: r8a73a4: Remove init_irq
 declaration in machine description
In-Reply-To: <1368545933-7430-10-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-10-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130515014744.GO12246@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 05:38:42PM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for shmobile as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-shmobile/setup-r8a73a4.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
> index c5a75a7..0b78896 100644
> --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
> @@ -18,7 +18,6 @@
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>  #include <linux/irq.h>
> -#include <linux/irqchip.h>
>  #include <linux/kernel.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_data/irq-renesas-irqc.h>
> @@ -194,7 +193,6 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
>  };
>  
>  DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
> -	.init_irq	= irqchip_init,
>  	.init_machine	= r8a73a4_add_standard_devices_dt,
>  	.init_time	= shmobile_timer_init,
>  	.dt_compat	= r8a73a4_boards_compat_dt,

Queued up for v3.11 in the boards-r8a73a4 branch of my renesas tree
on kernel.org. It is included in the renesas-next-20130515 tag of
that tree and should appear in linux-next in the not to distant future.
