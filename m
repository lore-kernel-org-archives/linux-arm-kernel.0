From: abhilash.kv@ti.com (Koyamangalath, Abhilash)
Date: Wed, 25 May 2011 18:45:21 +0530
Subject: [PATCH v3] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
In-Reply-To: <20110524190718.GA6899@avinash-laptop>
References: <1304328111-15999-1-git-send-email-avinashhm@ti.com>
	<alpine.DEB.2.00.1105051548210.30136@utopia.booyaka.com>
	<20110509124842.GA25211@avinash-laptop>
	<alpine.DEB.2.00.1105181021590.4550@utopia.booyaka.com>
	<20110518162542.GB3026@avinash-laptop>
	<FCCFB4CDC6E5564B9182F639FC3560870370A4D887@dbde02.ent.ti.com>,
	<20110524190718.GA6899@avinash-laptop>
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370A4D88F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>On Thu, May 19, 2011 at 06:05:21PM +0530, Koyamangalath, Abhilash wrote:
>
> > I have tried the patch on am37x evm and the i2c soft-reset time-out issue doesn't
> > seem to go off for me. Previously I used to get a log  :
> >
> > [    0.000000] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
> > [    0.000000] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
> > [    0.000000] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
> >
> > And now I get :
> > [    0.000000] omap_i2c_reset: i2c1: softreset failed (waited 10000 usec)
> > [    0.000000] omap_i2c_reset: i2c2: softreset failed (waited 10000 usec)
> > [    0.000000] omap_i2c_reset: i2c3: softreset failed (waited 10000 usec)
> >
> > So the function where this failure happens seems to be the only thing that has changed.
> > I've tried this patch on top of the recent PSP 04.02.00.07 release.
> > What am I missing?
>
>Abhilash ,
>
>I am not sure what is PSP 04.02.00.07 release. But you should make sure
>that the hwmod structures in omap_hwmod_3xxx_data.c should have the
>16_bit flags.
>
>Below is just a snippet in P.S.. There is already a patch submitted by
>andy green for this. Not sure, if it is merged.
>
>With this and the posted v3 patch, you should not see timeouts. Or else
>you have some other problem.
>
>thanks ,
>
>- Avinash
>
>PS:
>
> static struct omap_hwmod omap3xxx_i2c1_hwmod = {
>        .name           = "i2c1",
>+       .flags          = HWMOD_16BIT_REG,

Yes Avinash, that works , 
thanks.
>
>
> >
> > thanks,
> > Abhilash
> >
> >
> >
> > > >
> > > >
> > > > - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
