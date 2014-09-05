From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 5 Sep 2014 16:34:57 +0100
Subject: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <20140905092120.GG13515@arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173740.GJ1824@e102568-lin.cambridge.arm.com>
 <20140904160320.GB22354@arm.com>
 <20140904172909.GA14822@e102568-lin.cambridge.arm.com>
 <20140905092120.GG13515@arm.com>
Message-ID: <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 10:21:20AM +0100, Will Deacon wrote:
> On Thu, Sep 04, 2014 at 06:29:10PM +0100, Lorenzo Pieralisi wrote:
> > On Thu, Sep 04, 2014 at 05:03:20PM +0100, Catalin Marinas wrote:
> > > On Wed, Sep 03, 2014 at 06:37:40PM +0100, Lorenzo Pieralisi wrote:
> > > > This patch should be ready to go too, is it ok if I split the series
> > > > in arm64 arch specific patches (will ask Catalin to pull) and CPUidle ones
> > > > (inclusive of DT bindings and !!this patch!!) and send two separate pull
> > > > requests ?
> > > 
> > > If Daniel/Rafael don't have any objection, I can take the whole series
> > > through the arm64 tree (it seems that patches have been already acked by
> > > Daniel).
> > 
> > Thanks a lot Catalin. Since this one is a brand new CPUidle driver and it
> > follows a different pattern from arm legacy drivers I would like to get
> > Daniel's ack on this patch too before pushing it. For the records I have
> > just added two pr_err to signal driver probing error, ultraminor changes
> > that do not justify a repost.
> > 
> > If Samsung guys do not manifest themselves I would drop patch 8 from
> > the series till it gets tested and its patch dependency queued too.
> 
> The last patch also has a dependency, as you mentioned to Daniel. I think
> we can certainly merge the arm64 parts, and if Daniel doesn't object, then
> we can take the driver stuff too but leaving the exynos bits out (i.e. drop
> the last patch).
> 
> Anyway, if you could repost with the acks you've collected and rearrange it
> so the arm64 patches are first in the series, that would be great.

I can repost it with the acks and rearrange the patches, but for the
pull request I have to know what code can be merged, since there are
some arm64 patches (PSCI and CPUidle arm64 back-end) that are strictly
tied to the arm64 CPUidle driver, so I *have* to know if the arm64
CPUidle driver (this patch) can get merged and that requires an ack.

If I do not hear from Samsung guys I will drop patch 8.

I will wait till Monday (ie -rc4) and repost, I hope that's acceptable.

Thank you !
Lorenzo
