From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Mon, 6 Jun 2011 12:53:57 +0530
Subject: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
In-Reply-To: <4DEC7B6D.6060901@ti.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
	<4DEC7B6D.6060901@ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B7B69A6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Monday, June 06, 2011 12:32 PM
> To: Colin Cross
> Cc: linux-omap at vger.kernel.org; Tony Lindgren; Russell King; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
> 
> On 6/5/2011 12:33 AM, Colin Cross wrote:
> > Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
> > causing only the last bit set to take effect, resulting in lost
> > wakeups when the GPIO controller is in idle.
> >
> > Replace direct writes to IRQWAKEN with writes to SETWKUENA and
> > CLEARWKUEN.
> >
> > Signed-off-by: Colin Cross<ccross@android.com>
> 
> Looks good. This needs to be fixed on top of the clean-up
> branch where GPIO movemnt to driver/gpio/* happening.
> 
> For this change,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
This is also available as part of following cleanup series we are doing.
However, since this is a defect we can prioritize it over the cleanup.
--
Tarun
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
