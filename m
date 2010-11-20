From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 20 Nov 2010 15:38:42 +0530
Subject: [PATCH 5/5] omap4: l2x0: Enable early BRESP bit
In-Reply-To: <yw1xfwux411g.fsf@unicorn.mansr.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-5-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-6-git-send-email-santosh.shilimkar@ti.com>
	<yw1xfwux411g.fsf@unicorn.mansr.com>
Message-ID: <fc42ca6f03504dea078f111b3ef03a4a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: M?ns Rullg?rd [mailto:mans at mansr.com]
> Sent: Saturday, November 20, 2010 12:02 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; nm at ti.com; mans at mansr.com;
> tony at atomide.com; khilman at deeprootsystems.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 5/5] omap4: l2x0: Enable early BRESP bit
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > The AXI protocol specifies that the write response can only
> > be sent back to an AXI master when the last write data has been
> > accepted. This optimization enables the PL310 to send the write
> > response of certain write transactions as soon as the store buffer
> > accepts the write address. This behavior is not compatible with
> > the AXI protocol and is disabled by default. You enable this
> > optimization by setting the Early BRESP Enable bit in the
> > Auxiliary Control Register (bit [30]).
>
> Did you measure the performance difference this makes, if any?
>
I didn't do any special runs for this bit alone. Just checked
with hardware team and they confirmed that you would gain a bit
on writes and it's good to enable it.
