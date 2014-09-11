From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 11 Sep 2014 09:57:28 +0100
Subject: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <54115D16.30206@linaro.org>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173740.GJ1824@e102568-lin.cambridge.arm.com>
 <20140904160320.GB22354@arm.com>
 <20140904172909.GA14822@e102568-lin.cambridge.arm.com>
 <20140905092120.GG13515@arm.com>
 <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
 <54115D16.30206@linaro.org>
Message-ID: <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 09:28:06AM +0100, Daniel Lezcano wrote:
> On 09/05/2014 05:34 PM, Lorenzo Pieralisi wrote:
> > On Fri, Sep 05, 2014 at 10:21:20AM +0100, Will Deacon wrote:
> >> On Thu, Sep 04, 2014 at 06:29:10PM +0100, Lorenzo Pieralisi wrote:
> >>> On Thu, Sep 04, 2014 at 05:03:20PM +0100, Catalin Marinas wrote:
> >>>> On Wed, Sep 03, 2014 at 06:37:40PM +0100, Lorenzo Pieralisi wrote:
> >>>>> This patch should be ready to go too, is it ok if I split the series
> >>>>> in arm64 arch specific patches (will ask Catalin to pull) and CPUidle ones
> >>>>> (inclusive of DT bindings and !!this patch!!) and send two separate pull
> >>>>> requests ?
> >>>>
> >>>> If Daniel/Rafael don't have any objection, I can take the whole series
> >>>> through the arm64 tree (it seems that patches have been already acked by
> >>>> Daniel).
> >>>
> >>> Thanks a lot Catalin. Since this one is a brand new CPUidle driver and it
> >>> follows a different pattern from arm legacy drivers I would like to get
> >>> Daniel's ack on this patch too before pushing it. For the records I have
> >>> just added two pr_err to signal driver probing error, ultraminor changes
> >>> that do not justify a repost.
> >>>
> >>> If Samsung guys do not manifest themselves I would drop patch 8 from
> >>> the series till it gets tested and its patch dependency queued too.
> >>
> >> The last patch also has a dependency, as you mentioned to Daniel. I think
> >> we can certainly merge the arm64 parts, and if Daniel doesn't object, then
> >> we can take the driver stuff too but leaving the exynos bits out (i.e. drop
> >> the last patch).
> >>
> >> Anyway, if you could repost with the acks you've collected and rearrange it
> >> so the arm64 patches are first in the series, that would be great.
> >
> > I can repost it with the acks and rearrange the patches, but for the
> > pull request I have to know what code can be merged, since there are
> > some arm64 patches (PSCI and CPUidle arm64 back-end) that are strictly
> > tied to the arm64 CPUidle driver, so I *have* to know if the arm64
> > CPUidle driver (this patch) can get merged and that requires an ack.
> >
> > If I do not hear from Samsung guys I will drop patch 8.
> 
> Well I would prefer to have this patch merged (Cc'ing Tomasz).

Ok, but:

a) I only compile tested it
b) There is a dts patch dependency for patch 8 to apply cleanly and it
   hasn't been acked (I can't really do it since I can't test it)

   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274179.html

So, what should we do ? Tomasz ?

> > I will wait till Monday (ie -rc4) and repost, I hope that's acceptable.
> 
> There is a procedure to solve this branch dependency.
> 
> 1. Create a patchset with only the changes in drivers/cpuidle (+ misc dt 
> stuff)
> 
> 2. Send the patchset to me.

Ok. I will do it straight away.

> 3. I create a branch with these patches (which will be merged in my 
> cpuidle next branch)
> 4. Merge this branch to a new branch (based on 3.17-rcX) and put on top 
> of that your changes for ARM[64]
> 
> 5. Send the PR to Catalin and Arnd (one for each branch or one for both 
> arch)

There is no ARM code in my series. So to sum it up:

a) I send a pull request to Catalin for arm64 patches on top of the branch
   you are creating with my patches
b) You take care of merging the CPUidle related patches through your
   tree

Is the above what you meant ?

I will send you an mbox for CPUidle related patches straight away (well,
as soon as I know what to do with patch 8).

Thank you very much.
Lorenzo
