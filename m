From: abhilash.kv@ti.com (Koyamangalath, Abhilash)
Date: Thu, 19 May 2011 18:05:21 +0530
Subject: [PATCH v3] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
In-Reply-To: <20110518162542.GB3026@avinash-laptop>
References: <1304328111-15999-1-git-send-email-avinashhm@ti.com>
	<alpine.DEB.2.00.1105051548210.30136@utopia.booyaka.com>
	<20110509124842.GA25211@avinash-laptop>
	<alpine.DEB.2.00.1105181021590.4550@utopia.booyaka.com>,
	<20110518162542.GB3026@avinash-laptop>
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370A4D887@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Wed, May 18, 2011 at 10:22:28AM -0600, Paul Walmsley wrote:
> > On Mon, 9 May 2011, Avinash.H.M. wrote:
> >
> > > On Thu, May 05, 2011 at 03:58:56PM -0600, Paul Walmsley wrote:
> > >
> > > > >
> > > > > The patch is based on
> > > > >  * git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > > > >  * master branch.
> > > > >  * 9be20f0 commit. ( Linux-omap rebuilt: Updated to -rc5 )
> > > >
> > > > Please base all your patches against mainline commits.  I suggest using
> > > > v2.6.39-rc6.
> > >
> > > OK Paul. I will rebase against mainline, -rc6.
> >
> > Ping.  Any progress?
>
> Hi Paul ,
>
> I am having the patch ready. Haven't had a chance to test. I will test
> and send by tomorrow.

> thanks ,

> - Avinash
I have tried the patch on am37x evm and the i2c soft-reset time-out issue doesn't
seem to go off for me. Previously I used to get a log  : 

[    0.000000] omap_hwmod: i2c1: softreset failed (waited 10000 usec)                                                                                                            
[    0.000000] omap_hwmod: i2c2: softreset failed (waited 10000 usec)                                                                                                            
[    0.000000] omap_hwmod: i2c3: softreset failed (waited 10000 usec) 

And now I get :
[    0.000000] omap_i2c_reset: i2c1: softreset failed (waited 10000 usec)
[    0.000000] omap_i2c_reset: i2c2: softreset failed (waited 10000 usec)
[    0.000000] omap_i2c_reset: i2c3: softreset failed (waited 10000 usec)

So the function where this failure happens seems to be the only thing that has changed.
I've tried this patch on top of the recent PSP 04.02.00.07 release. 
What am I missing?

thanks,
Abhilash



> >
> >
> > - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
