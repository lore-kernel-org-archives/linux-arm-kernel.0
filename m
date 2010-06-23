From: ivo.clarysse@gmail.com (Ivo Clarysse)
Date: Wed, 23 Jun 2010 11:23:55 +0200
Subject: [PATCHv3 4/5] mtd: mxc_nand fixups
In-Reply-To: <80vd9ab0d2.fsf@merkur.tec.linutronix.de>
References: <804oh0b7gx.fsf@merkur.tec.linutronix.de>
	<20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
	<AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
	<80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTikRj_dMkKLyFhW78yld9jIYAIFncfPaPAF8WqUY@mail.gmail.com>
	<80iq5bqd07.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTimJKNEwOoKldq4a4_ufxNY6IY7r6tAfAM055hlW@mail.gmail.com>
	<80vd9ab0d2.fsf@merkur.tec.linutronix.de>
Message-ID: <AANLkTinVaXjCneg-XpxB7YNlmGOwQFTnm5RUcetPdToI@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 10:48 AM, John Ogness <john.ogness@linutronix.de> wrote:
[...]
>
> OK. Now I understand the problem. Here is a new patch that introduces a
> flag that is set by the interrupt handler. This way we do not rely on
> the i.MX21 being able to read NFC_INT when the interrupt is masked.

Yes, this works on i.MX21 (tested on an MX21ADS board).

[...]
> @@ -117,6 +118,7 @@ struct mxc_nand_host {
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? clk_act;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? irq;
>
> + ? ? ? int ? ? ? ? ? ? ? ? ? ? nfc_int;

But is it OK to use a regular (non-volatile) variable to communicate
between interrupt context and the non-interrupt context ?

My original patch for i.MX21 used completions instead:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/012694.html
