From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 8 Jul 2011 08:46:37 -0600
Subject: [PATCH] ARM: mmp: remove SPARSE_IRQ for mmp
In-Reply-To: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACxGe6sg=RQKQKVXh-XU5V_PkO8ZA7ho5fXx+oRxzEJV10pxVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 8, 2011 at 4:20 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Avoid to use SPARSE_IRQ for mmp. There will be irq domain translation between
> DT irq specifier and the Linux irq number.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

I believe the goal is to use more sparse_irq, not less, and the
irq_domain code works fine either way.

g.

> ---
> ?arch/arm/Kconfig | ? ?1 -
> ?1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 17507b8..48748fb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -545,7 +545,6 @@ config ARCH_MMP
> ? ? ? ?select HAVE_SCHED_CLOCK
> ? ? ? ?select TICK_ONESHOT
> ? ? ? ?select PLAT_PXA
> - ? ? ? select SPARSE_IRQ
> ? ? ? ?help
> ? ? ? ? ?Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
>
> --
> 1.5.6.5
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
