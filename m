From: cxie4@marvell.com (Chao Xie)
Date: Thu, 8 Sep 2011 22:30:01 -0700
Subject: [PATCH 1/4] ARM: mmp: add irq_disable callback for gpio chip
In-Reply-To: <CAMPhdO_S4jSFBgDAeSQuMa-LEz1Bcxxbi1eRg_XHbT-=1_0XTw@mail.gmail.com>
References: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
	<CAMPhdO_S4jSFBgDAeSQuMa-LEz1Bcxxbi1eRg_XHbT-=1_0XTw@mail.gmail.com>
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D154C14452E@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When driver invoke disable_irq to disable the gpio irq, it will failed to mask the bit in gpio register. Irq will still generate although the irq_handler for the gpio is not invoked.

-----Original Message-----
From: Eric Miao [mailto:eric.y.miao at gmail.com] 
Sent: Friday, September 09, 2011 11:28 AM
To: Chao Xie
Cc: linux-arm-kernel at lists.infradead.org; Haojian Zhuang; linux at arm.linux.org.uk
Subject: Re: [PATCH 1/4] ARM: mmp: add irq_disable callback for gpio chip

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
