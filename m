From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Sep 2016 11:06:24 +0100
Subject: [PATCH v4 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <20160901163051.GA6731@leverpostej>
References: <1472576493-26382-1-git-send-email-nleeder@codeaurora.org>
 <1472576493-26382-3-git-send-email-nleeder@codeaurora.org>
 <20160901163051.GA6731@leverpostej>
Message-ID: <20160902100624.GB9261@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 05:30:52PM +0100, Mark Rutland wrote:
> On Tue, Aug 30, 2016 at 01:01:33PM -0400, Neil Leeder wrote:
> > +static DEFINE_MUTEX(l2cache_pmu_mutex);
> 
> A mutex (which can sleep) is not safe for the hotplug state machine
> stuff. See recent patches to the arm_pmu code.
> 
> That's further subsumed by the multi-instance stuff, so this (and the
> list) will not be necessary shortly.

This has *just* landed in tip. See the smp/hotplug branch [1]. The
arm_pmu change [2] should serve as an example of what to do.

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=smp/hotplug
[2] https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=smp/hotplug&id=cc727977acb0fe05b7aa1f00cccb893530820895
