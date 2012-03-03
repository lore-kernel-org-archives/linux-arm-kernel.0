From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sat, 03 Mar 2012 19:09:13 +0400
Subject: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
In-Reply-To: <1330707024-23730-12-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-12-git-send-email-b-cousson@ti.com>
Message-ID: <4F523419.3080100@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-03-2012 20:50, Benoit Cousson wrote:

> Card detect IRQ from the TWL6030 used to be provided to the MMC

> controller code using a statically allocated IRQ scheme:
>
>    card_detect_irq = TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;
>
> This is no longer valid in a SPARSE_IRQ context since there is no more
> pre-defined TWL6030_IRQ_BASE.
>
> Return the proper card detect IRQ value in the twl6030_mmc_card_detect_config
> that will be called from the MMC controller.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> ---
>   drivers/mfd/twl6030-irq.c |    3 ++-

     Subject talks about twl4030-irq.

WBR, Sergei
