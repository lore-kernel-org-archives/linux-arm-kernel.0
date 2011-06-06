From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 Jun 2011 16:54:25 +0200 (CEST)
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <4DECD8C0.6010908@freyther.de>
References: <4DECCADE.6080100@selfish.org> <4DECD8C0.6010908@freyther.de>
Message-ID: <alpine.LFD.2.02.1106061650210.13964@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2011, Holger Hans Peter Freyther wrote:

> On 06/06/2011 02:41 PM, Holger Freyther wrote:
> > Hi,
> > 
> > my not mainlined with custom drivers board support seems to suffer from an
> > issue introduced by moving the irq.c to the generic GPIO interrupt code
> > (aac4dd1dab8acfc244d697473d2a5f4424a5746c, reverting it makes the oops go
> > away). I think this is caused by either interrupt #46 or #47 on this system
> > which is on the second 'bank'.
> 
> I resorted to printf debugging, it is IRQ 56 which is the IRQ_GPIOBNK0.. so I
> wonder if this IRQ should end up in the GC GPIO code at all?

That depends on davinci_soc_info.intc_irq_num.

#define DAVINCI_N_AINTC_IRQ     64
#define DA830_N_CP_INTC_IRQ     96
#define TNETV107X_N_CP_INTC_IRQ                 96

No idea which one applies to your machine, but for all in tree boards
56 is in the range of intc interrupts.

Thanks,

	tglx
