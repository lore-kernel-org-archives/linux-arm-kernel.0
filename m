From: holger@freyther.de (Holger Hans Peter Freyther)
Date: Mon, 06 Jun 2011 15:40:16 +0200
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <4DECCADE.6080100@selfish.org>
References: <4DECCADE.6080100@selfish.org>
Message-ID: <4DECD8C0.6010908@freyther.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2011 02:41 PM, Holger Freyther wrote:
> Hi,
> 
> my not mainlined with custom drivers board support seems to suffer from an
> issue introduced by moving the irq.c to the generic GPIO interrupt code
> (aac4dd1dab8acfc244d697473d2a5f4424a5746c, reverting it makes the oops go
> away). I think this is caused by either interrupt #46 or #47 on this system
> which is on the second 'bank'.

I resorted to printf debugging, it is IRQ 56 which is the IRQ_GPIOBNK0.. so I
wonder if this IRQ should end up in the GC GPIO code at all?
