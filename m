From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Mar 2014 03:35:30 +0900
Subject: [PATCH v2 6/6] ARM: s5p64x0: Explicitly include linux/serial_s3c.h
 in mach/pm-core.h
In-Reply-To: <1395162964-5916-6-git-send-email-t.figa@samsung.com>
References: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
 <1395162964-5916-6-git-send-email-t.figa@samsung.com>
Message-ID: <532B34F2.8050804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/14 02:16, Tomasz Figa wrote:
> This patch fixes compilation failure due to missing explicit inclusion
> of linux/serial_s3c.h in mach/pm-core.h, which contains definitions
> required for further code in this header.
>
> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
> ---
>   arch/arm/mach-s5p64x0/include/mach/pm-core.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-s5p64x0/include/mach/pm-core.h b/arch/arm/mach-s5p64x0/include/mach/pm-core.h
> index e52f754..1e0eb65 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/pm-core.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/pm-core.h
> @@ -12,6 +12,8 @@
>    * published by the Free Software Foundation.
>    */
>
> +#include<linux/serial_s3c.h>
> +
>   #include<mach/regs-gpio.h>
>
>   static inline void s3c_pm_debug_init_uart(void)

Applied, thanks.

- Kukjin
