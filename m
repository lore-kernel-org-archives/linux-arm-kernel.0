From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 5 Jul 2011 16:23:19 +0200
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <1309856728-8265-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1309856728-8265-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20110705142319.GA17137@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:05 Tue 05 Jul     , Thomas Petazzoni wrote:
> Several USB power switches (AIC1526 or MIC2026) have a digital output
> that is used to notify that an overcurrent situation is taking
> place. This digital outputs are typically connected to GPIO inputs of
> the processor and can be used to be notified of those overcurrent
> situations.
> 
> Therefore, we add a new overcurrent_pin[] array in the at91_usbh_data
> structure so that boards can tell the AT91 OHCI driver which pins are
> used for the overcurrent notification. The AT91 OHCI driver simply
> registers an interrupt handler which will log the entry and exit of an
> overcurrent situation in the kernel logs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/include/mach/board.h |    1 +
>  drivers/usb/host/ohci-at91.c            |   37 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index 61d52dc..1f90d79 100644
> --- a/arch/arm/mach-at91/include/mach/board.h
> +++ b/arch/arm/mach-at91/include/mach/board.h
> @@ -99,6 +99,7 @@ struct at91_usbh_data {
>  	u8		ports;		/* number of ports on root hub */
>  	u8		vbus_pin[2];	/* port power-control pin */
>  	u8              vbus_pin_inverted;
> +	u8              overcurrent_pin[2]; /* over-current signal pins */
please use named resourcees and provide the irq number

Best Regards,
J.
