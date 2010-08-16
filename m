From: john.ogness@linutronix.de (John Ogness)
Date: Mon, 16 Aug 2010 14:05:44 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <20100816112837.GO27749@pengutronix.de> (Sascha Hauer's message
	of "Mon, 16 Aug 2010 13:28:37 +0200")
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
	<20100811125625.GS27749@pengutronix.de>
	<80r5i5z3v1.fsf@merkur.tec.linutronix.de>
	<20100816112837.GO27749@pengutronix.de>
Message-ID: <80zkwm69uv.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-08-16, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Ok, here is an updated version of this patch
>
> Sascha
>
> commit 3a411e6c690654f78bea93dd8cdb14c27ba418a5
> Author: Sascha Hauer <s.hauer@pengutronix.de>
> Date:   Mon Aug 9 14:21:00 2010 +0200
>
>     mxc_nand: do not depend on disabling the irq in the interrupt handler
>     
>     This patch reverts the driver to enabling/disabling the NFC interrupt
>     mask rather than enabling/disabling the system interrupt. This cleans
>     up the driver so that it doesn't rely on interrupts being disabled
>     within the interrupt handler.
>     For i.MX21 we keep the current behaviour, that is calling
>     enable_irq/disable_irq_nosync to enable/disable interrupts.
>     This patch is based on earlier work by John Ogness.

Acked-by: John Ogness <john.ogness@linutronix.de>    

>     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
