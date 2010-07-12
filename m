From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Jul 2010 10:11:06 +0200
Subject: [RFC PATCH 1/2] allow each machine to specify it's own IRQ
	handlers at run-time
In-Reply-To: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
References: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
Message-ID: <20100712081106.GB1532@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Sat, May 22, 2010 at 12:23:29PM +0800, Eric Miao wrote:
> commit edec494b3dbf52a61a18b484dd05cce6a9d90e2f
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Sat May 22 11:58:01 2010 +0800
> 
>     [ARM] allow each machine to specify it's own IRQ handlers at run-time
> 
>     Normally different ARM platform has different way to decode the IRQ
>     hardware status and demultiplex to the corresponding IRQ handler.
>     This is highly optimized by macro irq_handler in entry-armv.S, and
>     each machine class defines their own macro to decode the IRQ number.
>     However, this prevents multiple machine classes to be built into a
>     single kernel.
> 
>     By allowing each machine to specify thier own handler, and making
>     function pointer 'handle_arch_irq' to point to it at run time, this
>     can be solved. And introduce CONFIG_MULTI_IRQ_HANDLER to allow both
>     solutions to work.
> 
>     Comparing with the highly optimized macro of irq_handler, the new
>     function must be written with care not to lose too much performance.
> 
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
I didn't thought it would be that easy.  Nice.
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe
