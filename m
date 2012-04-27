From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 11:02:05 +0800
Subject: [PATCH] arm/sa1100: fix sa1100-rtc memory resource
In-Reply-To: <1334384779-532-1-git-send-email-mad_soft@inbox.ru>
References: <1334384779-532-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <CAN1soZwQ9BBp+=mZZm6tL+r2j5-wX-mFkeBPCOuqCGkibZ0R1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 2:26 PM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> DEFINE_RES_MEM() takes the size of resource as a second argument,
> not the end address. Passing end address leads to following error
> in runtime during device registration:
> sa1100-rtc: failed to claim resource 0
>
> Fix it.
>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> ---
> ?arch/arm/mach-sa1100/generic.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> For reference: bug was introduced by commit 3888c09074
> ("rtc: sa1100: declare irq in resource")
>
> diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
> index 7c524b4..16be4c5 100644
> --- a/arch/arm/mach-sa1100/generic.c
> +++ b/arch/arm/mach-sa1100/generic.c
> @@ -306,7 +306,7 @@ void sa11x0_register_irda(struct irda_platform_data *irda)
> ?}
>
> ?static struct resource sa1100_rtc_resources[] = {
> - ? ? ? DEFINE_RES_MEM(0x90010000, 0x9001003f),
> + ? ? ? DEFINE_RES_MEM(0x90010000, 0x40),
> ? ? ? ?DEFINE_RES_IRQ_NAMED(IRQ_RTC1Hz, "rtc 1Hz"),
> ? ? ? ?DEFINE_RES_IRQ_NAMED(IRQ_RTCAlrm, "rtc alarm"),
> ?};
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/

Applied

Regards
Haojian
