From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Wed, 9 Jun 2010 00:38:55 -0500
Subject: [PATCH 09/10] omap: mailbox: convert block api to kfifo
In-Reply-To: <AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>,
	<AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
Message-ID: <496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Ohad,

________________________________________
>From: Ohad Ben-Cohen [ohad at wizery.com]
>Sent: Tuesday, June 08, 2010 9:35 PM
>To: Sapiens, Rene; Guzman Lugo, Fernando
>Cc: Hiroshi DOYU; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Kanigeri, Hari
>Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
>
>Hi Rene,
>
>On Tue, Jun 8, 2010 at 7:16 PM, Sapiens, Rene <rene.sapiens@ti.com> wrote:
>> In mbox_rx_work() you are removing the lines that enable back the  mbox irq for the RX case, but inside  __mbox_rx_interrupt() this interrupt  is disabled in the case that the kfifo for Rx >mailbox gets full. So I think that we need to enable it back as soon as there is space in this kfifo.
>
>
>
>Actually these irq on/off lines are not part of my patch; they are
>introduced by patch 05/10 on top of which my patches were rebased.
>
>Nevertheless I agree with you - the kfifo migration patch should not
>affect that irq on/off behavior. It's probably just a rebase gotcha.
>
>But now that you point me to this irq on/off thing, it looks a bit
>broken in terms of multiple concurrent mbox support since it relies on
>a global rq_full state. I guess it'd be better to hold that rq_full
>state in the relevant mbox queue state itself.
>
>Fernando what do you think ?

Yes, you are right Ohad. Only should be disable the "new message" interrupt of the mailbox which kfifo is full.

regards,
Fernando.

>
>Thanks,
>Ohad.
