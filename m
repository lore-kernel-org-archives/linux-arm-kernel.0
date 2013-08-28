From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 28 Aug 2013 08:28:25 +0200
Subject: [PATCH RFC v2 07/16] ARM: mvebu: remove custom .init_time hook
In-Reply-To: <1377638890-371-8-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-8-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <521D9889.7090109@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,
On 27/08/2013 23:28, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks.

You should update the commit log, the .init_time hooks won't be removed
with this patch.

Gregory

> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> v1->v2:
> - only remove of_clk_init from custom timer hook, further cleanup
>   will be carried out later (Reported by Gregory Clement)
> 
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index 829b573..164c62b 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -14,7 +14,6 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/clk-provider.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/io.h>
> @@ -36,7 +35,6 @@ static void __init armada_370_xp_map_io(void)
>  
>  static void __init armada_370_xp_timer_and_clk_init(void)
>  {
> -	of_clk_init(NULL);
>  	armada_370_xp_timer_init();
>  	coherency_init();
>  	BUG_ON(mvebu_mbus_dt_init());
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
