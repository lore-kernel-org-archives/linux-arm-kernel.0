From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Jan 2015 09:17:18 +0900
Subject: [PATCHv2 0/5] arm: specify PMU type in platform data
In-Reply-To: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
References: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150121001717.GB338@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 04:07:24PM +0000, Mark Rutland wrote:
> Currently the ARMv6, ARMv7, and XScale PMU drivers are coupled with each
> other, and all included in the same c file. To enable the splitting of
> the ARMv6, ARMv7, and XScale PMU drivers, and the conversion of the
> arm_pmu framework to a pure library, we need to be a be more precise
> when describing PMUs, to enable association of the PMU with the right
> driver. In device tree this is already implicit in the compatible
> string, but platform data currently only specifies "arm-pmu".
> 
> Commit 253d8c3d2518ca6f (arm: perf: add more specific platform device
> IDs) added "armv6-pmu", "armv7-pmu", and "xscale-pmu" platform device
> IDs, enabling the three to be distinguished. This series updates
> platform code to use these strings.
> 
> A later patch series will decouple the drivers.
> 
> Since v1 [1]:
> * Rebase to v3.19-rc4.
> * Add Acks.
> * Drop vexpress patches (platform code deleted).
> 
> Simon, in v1 you mentioned you were happy to take the shmobile patch
> through your tree. Are you still happy to do so, or to give your ack
> such that these can go through arm-soc together?
> 
> While I'm not too concerned which route these patches take, it would be
> nice to have a single base for the patches splitting the drivers.

Hi Mark,

assuming that this is targeted at v3.20 then it looks like your
changes do not conflict with anything I have queued up and
I am not likely to queue anything more up for the files in question
for that release. As my main concern is about conflicts I'm therefore
quite happy for you to take the shmobile patch through your tree.
I'll supply an ack accordingly.

> Thanks,
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304078.html
> 
> Mark Rutland (5):
>   arm: realview: specify PMU types
>   arm: pxa: specify PMUs are for XScale CPUs
>   arm: iop: specify PMUs are for XScale CPUs
>   arm: shmobile: specify PMUs are for ARMv7 CPUs
>   arm: omap: specify PMUs are for ARMv7 CPUs
> 
>  arch/arm/mach-omap2/pmu.c                | 5 +++--
>  arch/arm/mach-pxa/devices.c              | 2 +-
>  arch/arm/mach-realview/realview_eb.c     | 3 ++-
>  arch/arm/mach-realview/realview_pb1176.c | 2 +-
>  arch/arm/mach-realview/realview_pb11mp.c | 2 +-
>  arch/arm/mach-realview/realview_pba8.c   | 2 +-
>  arch/arm/mach-realview/realview_pbx.c    | 2 +-
>  arch/arm/mach-shmobile/setup-r8a7740.c   | 2 +-
>  arch/arm/mach-shmobile/setup-sh73a0.c    | 2 +-
>  arch/arm/plat-iop/pmu.c                  | 2 +-
>  10 files changed, 13 insertions(+), 11 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
