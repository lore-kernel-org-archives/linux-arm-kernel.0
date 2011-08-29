From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Mon, 29 Aug 2011 17:48:11 +0530
Subject: [PATCH v5 01/22] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <4E539E95.2080807@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-2-git-send-email-tarun.kanti@ti.com>
	<4E539E95.2080807@ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0384F03245@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> >   void omap2_gpio_prepare_for_idle(int off_mode)
> >   {
> > -	int i, c = 0;
> > -	int min = 0;
> > -
> > -	if (cpu_is_omap34xx())
> > -		min = 1;
> > +	int c = 0;
> > +	struct gpio_bank *bank;
> >
> > -	for (i = min; i<  gpio_bank_count; i++) {
> > -		struct gpio_bank *bank =&gpio_bank[i];
> > +	list_for_each_entry(bank,&omap_gpio_list, node) {
> >   		u32 l1 = 0, l2 = 0;
> >   		int j;
> >
> > +		/* TODO: Do not use cpu_is_omap34xx */
> 
> Is this addressed in subsequent patches ?
Yes.
--
Tarun
> 
> > +		if ((cpu_is_omap34xx())&&  (bank->id == 0))
> > +			continue;
> > +
> 
> Rest of the changes looks good to me.
> After you answer above, you can add my,
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Regards
> Santosh
