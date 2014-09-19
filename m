From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 19 Sep 2014 12:58:44 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <20140919102212.GA31784@xps8300>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de>
 <5419B825.5000201@linutronix.de> <20140919102212.GA31784@xps8300>
Message-ID: <541C0C64.5010206@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2014 12:22 PM, Heikki Krogerus wrote:
> Couldn't you just replace the handle_irq with a custom irq routine in
> the omap driver like you did with set_termios? Where you would do
> those tricks and/or call serial8250_handle_irq()?

Tricks within serial8250_handle_irq(), see [0]. It is not a lot but
still. I could provide my own handle irq, just asking what you would
prefer.

[0]
http://git.breakpoint.cc/cgit/bigeasy/linux.git/commit/?h=uart_v10_pre2&id=f26f161d998ee4a84a0aa6ddff69a435c25f204d

> The 8250_core changes in that patch #10 only modify
> serial8250_handle_irg right?

Correct. However there is another change due to the RX_DMA_BUG. A while
ago you said that this RX_DMA_BUG thing might be something that other
SoC could use, too.
If you ask me now for my own irq routine it would make sense to move RX
bug handling into omap specific code as well.

> Cheers,

Sebastian
