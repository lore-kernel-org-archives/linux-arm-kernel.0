From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Jan 2015 14:48:02 -0800
Subject: [PATCH 3/3] remoteproc: wkup_m3: Add wkup_m3 remote proc driver
In-Reply-To: <20150105202032.GQ19336@saruman>
References: <1420228319-41085-1-git-send-email-d-gerlach@ti.com>
 <1420228319-41085-4-git-send-email-d-gerlach@ti.com>
 <20150102200424.GD4920@saruman> <54AAEFA6.3080603@ti.com>
 <20150105202032.GQ19336@saruman>
Message-ID: <20150105224802.GM4081@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150105 12:23]:
> On Mon, Jan 05, 2015 at 02:10:14PM -0600, Dave Gerlach wrote:
> > >> +static int wkup_m3_rpm_suspend(struct device *dev)
> > >> +{
> > >> +	return -EBUSY;
> > >> +}
> > > 
> > > looks like this is just coping with omap_device bogosity, no ?
> > >
> > 
> > Yes, without this omap_device shuts down ther wkup_m3 during suspend, which of
> > course prevents the wkup_m3 from finishing suspend process or waking SoC back
> > up. Haven't found a better solution for the problem than this.
> 
> Tony, any better for this ? Do we keep this small hack or find a better
> way ?

Looks OK to me for now, later on we may want to have a flag for
HWMOD_NEVER_IDLE or something similar for wkup_m3_hwmod. But let's
not add more dependencies to this series.

Regards,

Tony
