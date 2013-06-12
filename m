From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Jun 2013 00:00:08 +0200
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130612220008.GG11232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jun 12, 2013 at 11:50:35PM +0200, Uwe Kleine-K?nig wrote:
> This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.
> 
> Support for this controller appeared in Catalin's Cortex tree based on
> 2.6.33 but was nearly completely rewritten.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v3, sent with
>     Message-Id: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>:
>     
>      - use generic chip
>      - rename nvic_do_IRQ to nvic_handle_irq
>     
>     This depends on the stuff currently in tip/irq/for-arm
It also depends on Russell King's devel-stable branch. So the options to
apply it in case you are otherwise happy with it:

 - apply on top of tip/irq/for-arm dropping the change to
   arch/arm/kernel/entry-v7m.S and let me add that change seperately; or
 - let it go through Russell's tree (the dependency on tip/irq/for-arm
   doesn't stop the patch to be applied on that one, it just won't
   compile); or
 - wait until there is a tree that contains both branches; or
 - merge the two trees and apply it on top of the merge.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
