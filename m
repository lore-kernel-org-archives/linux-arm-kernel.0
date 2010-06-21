From: ivo.clarysse@gmail.com (Ivo Clarysse)
Date: Mon, 21 Jun 2010 13:47:41 +0200
Subject: [PATCHv2 4/5] mtd: mxc_nand fixups
In-Reply-To: <80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
References: <804oh0b7gx.fsf@merkur.tec.linutronix.de>
	<20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
	<AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
	<80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
Message-ID: <AANLkTikRj_dMkKLyFhW78yld9jIYAIFncfPaPAF8WqUY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 20, 2010 at 11:21 AM, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2010-06-20, Ivo Clarysse <ivo.clarysse@gmail.com> wrote:
> > Yes, on i.MX21, NFC interrupts can be masked using
> > NFC_CONFIG1:NFC_INT_MSK. ?But I observed that as long as NFC_INT_MSK
> > is set, NFC_CONFIG2:NFC_INT will always read out 0 on i.MX21, even if
> > the operation is completed.
> >
> > So the driver will remain stuck at:
> >
> > ? ? ? ? ? ? ? ? ?wait_event(host->irq_waitq,
> > ? ? ? ? ? ? ? ? ? ? ? ? ?readw(host->regs + NFC_CONFIG2) & NFC_INT);
>
> OK. Here is alternative patch. Do you have access to an i.MX21 to test
> this on?
>
> This patch fixes the driver so that the irq is requested as disabled. This
> prevents double irq enabling and also does not require the interrupt to
> be disabled within the interrupt handler. (Actually, I beleive this was
> the true intention of the original author.)
[...]

Yes, that was indeed my true intention :)

I tested this change on an MX21ADS board.

Acked-by: Ivo Clarysse <ivo.clarysse@gmail.com>
