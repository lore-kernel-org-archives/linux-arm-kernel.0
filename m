From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 10 Aug 2010 18:01:51 +0300
Subject: [PATCH 09/10] omap: mailbox: convert block api to kfifo
In-Reply-To: <D2943F03B81C9C458E44DFB213905E02B7328E6C@dlee04.ent.ti.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
	<AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
	<AANLkTikZ2uDpuK1DjJLk_pSiogQyStwJVG952o79_NjX@mail.gmail.com>
	<D2943F03B81C9C458E44DFB213905E02B7328E6C@dlee04.ent.ti.com>
Message-ID: <AANLkTimhOg0o8m7DhLvDCCKHieyu0i4GRJM51=_WZUcm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 6:00 PM, Sapiens, Rene <rene.sapiens@ti.com> wrote:
> Hi Ohad,
>
> Sure I will do it.

Thanks a lot, Rene !
Ohad.


>
> Regards,
> Rene
>
>> -----Original Message-----
>> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
>> Sent: Tuesday, August 10, 2010 9:43 AM
>> To: Guzman Lugo, Fernando; Sapiens, Rene
>> Cc: Hiroshi DOYU; linux-omap at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; Kanigeri, Hari
>> Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
>>
>> Hi Rene,
>>
>>
>> On Wed, Jun 9, 2010 at 8:38 AM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>> >>On Tue, Jun 8, 2010 at 7:16 PM, Sapiens, Rene <rene.sapiens@ti.com>
>> wrote:
>> >>> In mbox_rx_work() you are removing the lines that enable back
>> the ?mbox irq for the RX case, but inside ?__mbox_rx_interrupt() this
>> interrupt ?is disabled in the case that the kfifo for Rx >mailbox gets
>> full. So I think that we need to enable it back as soon as there is space
>> in this kfifo.
>> >>
>> >>
>> >>Actually these irq on/off lines are not part of my patch; they are
>> >>introduced by patch 05/10 on top of which my patches were rebased.
>> >>
>> >>Nevertheless I agree with you - the kfifo migration patch should not
>> >>affect that irq on/off behavior. It's probably just a rebase gotcha.
>> >>
>> >>But now that you point me to this irq on/off thing, it looks a bit
>> >>broken in terms of multiple concurrent mbox support since it relies on
>> >>a global rq_full state. I guess it'd be better to hold that rq_full
>> >>state in the relevant mbox queue state itself.
>> >>
>> >>Fernando what do you think ?
>> >
>> > Yes, you are right Ohad. Only should be disable the "new message"
>> interrupt of the mailbox which kfifo is full.
>>
>>
>>
>> Once Fernando's fix will get thru, we will be able to fix the rebase
>> error that you pointed out.
>>
>> Unfortunately I will not have any email access in the next 3 weeks,
>> and I was hoping maybe you could submit a fix for this once Fernando's
>> fix is accepted ? I would really like us to fix this early in the days
>> of 2.6.36, maybe even during the merge window.
>>
>> Thanks a lot,
>> Ohad.
>>
>> >
>> > regards,
>> > Fernando.
>> >
>> >>
>> >>Thanks,
>> >>Ohad.
>> >
>
