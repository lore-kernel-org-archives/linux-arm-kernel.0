From: ivo.clarysse@gmail.com (Ivo Clarysse)
Date: Fri, 25 Jun 2010 16:46:44 +0200
Subject: [PATCHv3 4/5] mtd: mxc_nand fixups
In-Reply-To: <20100624072732.GQ12115@pengutronix.de>
References: <20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
	<AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
	<80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTikRj_dMkKLyFhW78yld9jIYAIFncfPaPAF8WqUY@mail.gmail.com>
	<80iq5bqd07.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTimJKNEwOoKldq4a4_ufxNY6IY7r6tAfAM055hlW@mail.gmail.com>
	<80vd9ab0d2.fsf@merkur.tec.linutronix.de>
	<AANLkTinVaXjCneg-XpxB7YNlmGOwQFTnm5RUcetPdToI@mail.gmail.com>
	<80lja6awlb.fsf@merkur.tec.linutronix.de>
	<20100624072732.GQ12115@pengutronix.de>
Message-ID: <AANLkTilG2AhYtQkb8V0u9851JP1vHhqrJTWKyRDGM36F@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 9:27 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
[...]
>
> BTW I observed that at least on i.MX27 the latencies introduced by
> waiting for an interrupt cause a significant performance drop. The
> driver gets much faster when we just poll all the time. I don't know how
> this affects system performance otherwise, but it may be a possibility
> to drop interrupt support at least for i.MX21. I have no idea how long
> the longest possible time we'd have to poll is though.

I'm noticing the same thing on i.MX21: when using interrupts,
"Scanning device for bad blocks" takes 982 (!) seconds.  When always
using polling, the same scan takes 'only' 500 seconds.


Ivo.
