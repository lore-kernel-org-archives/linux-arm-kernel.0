From: atull@opensource.altera.com (atull)
Date: Tue, 7 Oct 2014 09:19:00 -0500
Subject: [PATCH v2 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <20141007111052.GA6904@amd>
References: <1412192304-1209-1-git-send-email-atull@opensource.altera.com>
 <1412192304-1209-2-git-send-email-atull@opensource.altera.com>
 <20141007111052.GA6904@amd>
Message-ID: <alpine.DEB.2.02.1410070918000.9610@atx-linux-37>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Oct 2014, Pavel Machek wrote:

> On Wed 2014-10-01 14:38:23, atull at opensource.altera.com wrote:
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Use WFI when putting CPU1 to sleep.  Don't hold CPU1 in reset
> > since that results in increased power consumption.
> > 
> > Reset CPU1 briefly during CPU1 bootup.
> > 
> > This has been tested for hotplug and suspend/resume and results
> > in no increased power consumption.
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> 
> It is nice to Cc people who commented ont the patch before.

HI Pavel,

OK, adding you and others who commented.

> 
> >  	if (cpu1start_addr) {
> > +		/* This will put CPU #1 into reset. */
> > +		__raw_writel(RSTMGR_MPUMODRST_CPU1,
> > +			     rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
> > +
> 
> I thought conclusion was to use writel (not __raw variant) here?

Yes it was.  Fixed in v3, soon.

Alan

> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
