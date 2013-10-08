From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 11:05:26 -0700
Subject: [PATCH] ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit
 declarations.
In-Reply-To: <1381228141-16213-1-git-send-email-csmanjuvijay@gmail.com>
References: <1381228141-16213-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <20131008180526.GD8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Majunath Goudar <csmanjuvijay@gmail.com> [131008 03:37]:
> This patch adds a omap1510_fpga_init_irq() inline dummy implementations
> in arch/arm/mach-omap1/common.h. Without this patch,build system can
> lead to issues. This was discovered during randconfig testing,in which
> other than CONFIG_ARCH_OMAP15XX was enabled the leading to the following
> error:
> 
> CC      arch/arm/mach-omap1/board-innovator.o
> arch/arm/mach-omap1/board-innovator.c: In function ?innovator_init?:
> arch/arm/mach-omap1/board-innovator.c:377:3: error: implicit declaration of
> function ?omap1510_fpga_init_irq? [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/mach-omap1/board-innovator.o] Error 1
> make: *** [arch/arm/mach-omap1] Error 2

Thanks, I'll apply this into omap-for-v3.13/fixes-not-urgent
as it's been there for quite a while.

Regards,

Tony
 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> ---
>  arch/arm/mach-omap1/common.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index abec019..732f8ee 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -46,6 +46,9 @@ static inline void omap7xx_map_io(void)
>  void omap1510_fpga_init_irq(void);
>  void omap15xx_map_io(void);
>  #else
> +static inline void omap1510_fpga_init_irq(void)
> +{
> +}
>  static inline void omap15xx_map_io(void)
>  {
>  }
> -- 
> 1.7.9.5
> 
