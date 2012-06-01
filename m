From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Fri, 01 Jun 2012 10:36:11 +0300
Subject: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
In-Reply-To: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Message-ID: <4FC870EB.4060300@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2012 12:35 AM, Oleg Matcovschi wrote:
> Use omap_disable_channel_irq() function instead of directly accessing CICR.
> The omap_disable_chanel_irq() function clears pending interrupts
> and disables interrupt on channel.
> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> status register.
> 
> 
> Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
> ---
> v1 initial revision
> v2 Review by Tony Lindgren
> ---
>  arch/arm/plat-omap/dma.c |   59 +++++++++++++++++++++------------------------
>  1 files changed, 28 insertions(+), 31 deletions(-)
> 
Tested on BeagleBoard by using mmc and audio

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
