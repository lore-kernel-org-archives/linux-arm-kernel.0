From: john.ogness@linutronix.de (John Ogness)
Date: Wed, 23 Jun 2010 12:10:08 +0200
Subject: [PATCHv3 4/5] mtd: mxc_nand fixups
In-Reply-To: <AANLkTinVaXjCneg-XpxB7YNlmGOwQFTnm5RUcetPdToI@mail.gmail.com>
	(Ivo Clarysse's message of "Wed, 23 Jun 2010 11:23:55 +0200")
References: <804oh0b7gx.fsf@merkur.tec.linutronix.de>
	<20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
	<AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
	<80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTikRj_dMkKLyFhW78yld9jIYAIFncfPaPAF8WqUY@mail.gmail.com>
	<80iq5bqd07.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTimJKNEwOoKldq4a4_ufxNY6IY7r6tAfAM055hlW@mail.gmail.com>
	<80vd9ab0d2.fsf@merkur.tec.linutronix.de>
	<AANLkTinVaXjCneg-XpxB7YNlmGOwQFTnm5RUcetPdToI@mail.gmail.com>
Message-ID: <80lja6awlb.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-06-23, Ivo Clarysse <ivo.clarysse@gmail.com> wrote:
> But is it OK to use a regular (non-volatile) variable to communicate
> between interrupt context and the non-interrupt context ?

In this case, yes.

> My original patch for i.MX21 used completions instead:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/012694.html

Ah. It seems you've been through all this before. I wish I had noticed
that thread before. I will need to check more carefully in the future.

Yes, your original patch achieves the exact same thing. Whether we use
wait_event() with a flag or wait_completion() really is the same
thing. So I guess Sascha can decide what we should do there.

What I like about your original patch is that only the i.MX21 has the
cost of constantly enabling/disabling the irq line. It adds 5
cpu_is_mx21() blocks to the code, but will lead to less work for the CPU
on non-i.MX21 boards.

John Ogness
