From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 7 Jan 2015 07:51:34 -0500
Subject: [PATCH] irqchip: atmel-aic-common: prevent clobbering of
 priority when changing IRQ type
In-Reply-To: <1420598843-8409-1-git-send-email-gavinli@thegavinli.com>
References: <1420598843-8409-1-git-send-email-gavinli@thegavinli.com>
Message-ID: <20150107125134.GI24989@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gavin,

On Tue, Jan 06, 2015 at 06:47:23PM -0800, gavinli at thegavinli.com wrote:
> From: Gavin Li <git@thegavinli.com>
> 
> This patch makes the bitmask for AIC_SRCTYPE consistent
> with that of its valid values, and prevents the priority
> field at bits 2:0 from being clobbered by an incorrect
> AND with the AIC_SRCTYPE mask.
> 
> Signed-off-by: Gavin Li <gavinli@thegavinli.com>
> ---
>  drivers/irqchip/irq-atmel-aic-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Well done.  For a first patch this is really good.  The only thing you
missed was who/which MLs to Cc.  In the future, you can use
./scripts/get_maintainer.pl to find this info.

Applied to irqchip/urgent with Acks from the atmel maintainers and Cc'd
to stable for v3.17+

This will be in linux-next tonight if Stephen builds one.

thx,

Jason.
