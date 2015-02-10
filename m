From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 10 Feb 2015 10:32:17 +0100
Subject: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
In-Reply-To: <54D9441B.7070403@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-4-git-send-email-bigeasy@linutronix.de>
 <54D8B772.1010405@freebox.fr> <54D9441B.7070403@hurleysoftware.com>
Message-ID: <54D9D021.6000409@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2015 12:34 AM, Peter Hurley wrote:
> The "too much work" message means serial8250_handle_irq() is returning 0,
> ie., not handled. Which in turn means IIR indicates no interrupt is pending
> (UART_IIR_NO_INT == 1).

The OMAP UART for instance have two possible TX-IRQ handling. The
default is to fire the interrupt once there is room for at least one
byte in the FIFO. I set the OMAP_UART_SCR_TX_EMPTY bit to get the same
behavior as the 8250 driver expects (interrupt while the FIFO is empty).
Without this bit set I've seen the message from time to time.

Sebastian
