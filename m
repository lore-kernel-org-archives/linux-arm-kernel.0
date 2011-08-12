From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Aug 2011 10:15:28 +0100
Subject: [PATCH 2/2] ARM: perf: make name of arm_pmu_type consistent
In-Reply-To: <20110812090609.GJ4775@n2100.arm.linux.org.uk>
References: <1312981138-17020-1-git-send-email-mark.rutland@arm.com>
	<1312981138-17020-2-git-send-email-mark.rutland@arm.com>
	<20110812090609.GJ4775@n2100.arm.linux.org.uk>
Message-ID: <20110812091528.GA14904@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 10:06:09AM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2011 at 01:58:58PM +0100, Mark Rutland wrote:
> > Commit f12482c9 ("ARM: 6974/1: pmu: refactor reservation") changed
> > {release,reserve}_pmu to take an enum arm_pmu_type as a parameter, but
> > inconsistently named the parameter `type' or `device'. It would be nice
> > if these were consistent.
> > 
> > This patch makes use of enum arm_pmu_type consistent, always using
> > 'device' as this is more common in usage.
> 
> This is confusing.  It's called arm_pmu_TYPE, and it's referred to as a
> type in printks.  Yet you're renaming the variable to device.  That just
> adds to the problem.
> 
> What is it, a type number or a device number?
> 
> If it's a device number, then the printks also need fixing, and maybe the
> enumerated type name too.

Yes, we should uniformly use type instead of device. The only reason device
is kicking around is because the functions used to take a platform_device
rather than an arm_pmu_type.

Once I've got an updated patch from Mark, I'll update my fixes branch and
send a pull request to you Russell (I have a handful of other fixes that
have been on the list).

Cheers,

Will
