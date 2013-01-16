From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 Jan 2013 08:47:14 +0000
Subject: [PATCH 06/18] power: ab8500_bm: Recharge condition not optimal
 for battery
In-Reply-To: <20130116014442.GA17659@lizard.fhda.edu>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
 <1357909986-9262-7-git-send-email-lee.jones@linaro.org>
 <20130116014442.GA17659@lizard.fhda.edu>
Message-ID: <20130116084714.GE9379@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jan 2013, Anton Vorontsov wrote:

> On Fri, Jan 11, 2013 at 01:12:54PM +0000, Lee Jones wrote:
> > From: Marcus Cooper <marcus.xm.cooper@stericsson.com>
> > 
> > Today the battery recharge is determined with a voltage threshold. This
> > voltage threshold is only valid when the battery is relaxed. In charging
> > algorithm the voltage read is the loaded battery voltage and no
> > compensation is done to get the relaxed voltage. When maintenance
> > charging is not selected, this makes the recharging condition to almost
> > immediately activate when there is a discharge present on the battery.
> > 
> > Depending on which vendor the battery comes from this behavior can wear
> > out the battery much faster than normal.
> > 
> > The fuelgauge driver is responsible to monitor the actual battery
> > capacity and is able to estimate the remaining capacity. It is better to
> > use the remaining capacity as a limit to determine when battery should
> > be recharged.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Marcus Cooper <marcus.xm.cooper@stericsson.com>
> > Reviewed-by: Hakan BERG <hakan.berg@stericsson.com>
> > Reviewed-by: Jonas ABERG <jonas.aberg@stericsson.com>
> > ---
> > +	.maint_thres = 95,
> >  	.user_cap_limit = 15,
> >  	.maint_thres = 97,
> >  };
> 
> 95 or 97? These are both specified. I removed 97, assuming it was a merge
> error on your side. But please double check, it could be that you really
> want 97 here.

You did the correct thing, thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
