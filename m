From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 8 Sep 2011 20:28:11 -0700
Subject: [PATCH 1/4] ARM: mmp: add irq_disable callback for gpio chip
In-Reply-To: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
References: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
Message-ID: <CAMPhdO_S4jSFBgDAeSQuMa-LEz1Bcxxbi1eRg_XHbT-=1_0XTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chao,

I actually don't see why do we need irq_disable() here?

On Thu, Sep 8, 2011 at 9:18 PM, Chao Xie <chao.xie@marvell.com> wrote:
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?arch/arm/plat-pxa/gpio.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
> index a11dc36..15de09d 100644
> --- a/arch/arm/plat-pxa/gpio.c
> +++ b/arch/arm/plat-pxa/gpio.c
> @@ -263,6 +263,7 @@ static struct irq_chip pxa_muxed_gpio_chip = {
> ? ? ? ?.irq_ack ? ? ? ?= pxa_ack_muxed_gpio,
> ? ? ? ?.irq_mask ? ? ? = pxa_mask_muxed_gpio,
> ? ? ? ?.irq_unmask ? ? = pxa_unmask_muxed_gpio,
> + ? ? ? .irq_disable ? ?= pxa_mask_muxed_gpio,
> ? ? ? ?.irq_set_type ? = pxa_gpio_irq_type,
> ?};
>
> --
> 1.7.0.4
>
>
