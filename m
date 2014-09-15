From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 15 Sep 2014 19:01:57 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <5411B33F.10405@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de>
 <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de>
 <5411B33F.10405@hurleysoftware.com>
Message-ID: <54171B85.5060209@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2014 04:35 PM, Peter Hurley wrote:
> I do need to find out if omap hardware sets UART_MSR_DCTS when auto CTS
> is on. Would you mind running the debug patch below with HW flow control on?

I didn't forget about this. However I told minicom to use hardware flow
control (and I see the driver set the HW bit) but I haven't seen that
uart_handle_cts_change() has been invoked at all. I'm going to check
two other boards and report then.

> Regards,
> Peter Hurley

Sebastian
