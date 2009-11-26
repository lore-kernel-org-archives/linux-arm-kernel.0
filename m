From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Nov 2009 08:57:24 +0100
Subject: [PATCH] MXC: set GPIO IRQ handler
In-Reply-To: <807htelb5d.fsf@merkur.tec.linutronix.de>
References: <807htelb5d.fsf@merkur.tec.linutronix.de>
Message-ID: <20091126075724.GA12179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello John,

On Wed, Nov 25, 2009 at 07:19:58PM +0100, John Ogness wrote:
> The irq chip function gpio_set_irq_type() correctly sets the i.MX
> registers but does not set the irq handler.
I assume you see some breakage without your patch?  In mainline?

>                                             This means that all
> gpio-based irq's are handled with handle_edge_irq().
This is not true in mainline, until 060d20d (imx/gpio: Use
handle_level_irq) (currently in imx/mxc-master) hits Linus' tree ...

> This patch corrects this by also setting the appropriate handler.
> 
> This patch is against 2.6.32-rc8.
... so there is no hurry.

Can you please test with 060d20d if your breakage still occurs and
if it is still valid report some details (for me and the commit log)?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
