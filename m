From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Dec 2015 17:08:21 +0000
Subject: [PATCH v2 2/6] arm64: Move kill_cpu_early to smp.c
In-Reply-To: <56606FA3.3010802@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
 <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
 <20151201152826.GA28370@leverpostej> <565DC5DB.7070905@arm.com>
 <20151201163138.GA29045@leverpostej> <565DDB2E.2010308@arm.com>
 <20151201175254.GD29045@leverpostej> <565DE289.2000105@arm.com>
 <20151201185028.GF29045@leverpostej> <56606FA3.3010802@arm.com>
Message-ID: <20151203170820.GB3527@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:36:51PM +0000, Suzuki K. Poulose wrote:
> On 01/12/15 18:50, Mark Rutland wrote:
> >On Tue, Dec 01, 2015 at 06:10:17PM +0000, Suzuki K. Poulose wrote:
> >>On 01/12/15 17:52, Mark Rutland wrote:
> >>>On Tue, Dec 01, 2015 at 05:38:54PM +0000, Suzuki K. Poulose wrote:
> >>>>On 01/12/15 16:31, Mark Rutland wrote:
> >>OK. So the flag will also be used for CPUs which are stuck-in-the-kernel
> >>with MMU turned on. e.g, a CPU (using spin-table) we try to bring down
> >>in kill_cpu_early(). Correct ?
> >
> >Yes.
> >
> >We'd also pad it such that nothing else shares the same writeback
> >granule, and when writing to it with the MMU off we can invalidate the
> >stale cached copy.
> 
> I have started working on this approach. But the changes are a bit more invasive
> and looks more like suited for 4.5. We could push this series(which doesn't change
> the current behavior as it is in 4.4-rc3, except for the code movement) to fix
> the ASID sanity check and introduce the synchronisation part in 4.5.
> What do you think ?

I'm happy with that. I agree this patch as-is doesn't make matters
worse.

Thanks,
Mark.
