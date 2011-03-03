From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Mar 2011 22:01:51 +0530
Subject: [PATCH 11/17] omap4: suspend: Add MPUSS RET and OFF support
In-Reply-To: <87r5ap2lbg.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-12-git-send-email-santosh.shilimkar@ti.com>
	<87r5ap2lbg.fsf@ti.com>
Message-ID: <cbac34d988ad1a47e3b8d4e557a28130@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 4:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 11/17] omap4: suspend: Add MPUSS RET and OFF
> support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>

[...]
> > +
> > +	/* Set targeted power domain states by suspend */
> > +	list_for_each_entry(pwrst, &pwrst_list, node) {
> > +		/* FIXME: Remove this check when CORE retention is
> supported */
> > +		if (!strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
> > +			omap_set_pwrdm_state(pwrst->pwrdm, pwrst-
> >next_state);
> > +	}
>
> pwrst_list is the list of powerdomains to that will be changed
> during suspend.
>
> Rather than doing this string match for every suspend, just do the
> check once during init and only add powerdomains that can
> transition to the list.
>
Will fix this accordingly then.
