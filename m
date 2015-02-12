From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 12 Feb 2015 09:45:38 +0100
Subject: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
In-Reply-To: <54DBBE9E.90104@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-4-git-send-email-bigeasy@linutronix.de>
 <54D8B772.1010405@freebox.fr> <54D9441B.7070403@hurleysoftware.com>
 <54D9F3C7.5000809@freebox.fr> <54DA43F8.9090904@hurleysoftware.com>
 <54DBB531.2030504@hurleysoftware.com> <20150211200313.GE2531@atomide.com>
 <54DBBE9E.90104@hurleysoftware.com>
Message-ID: <54DC6832.3070507@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2015 09:42 PM, Peter Hurley wrote:

>> Reverting makes sense to me if it has caused a regression. Maybe Sebastian
>> can update his patch to do this based on some quirk flag instead?
> 
> That's fine with me. There's a 'bugs' field in struct 8250_uart_port and
> UART_BUG_* defines in 8250/8250.h for that purpose.

Makes sense. Reading an empty FIFO does not look right. Maybe we should
do the bug flag the other way around? But I can do what I am told to so
if there is more fallout than just this Marvell UART I could come
around with a patch to the bug field for the older OMAP.

> Regards,
> Peter Hurley

Sebastian
