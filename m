From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 12:47:13 +0900
Subject: [PATCH 09/10] ARM: shmobile: r8a7791 SMP support
In-Reply-To: <20131001081316.4136.4137.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081316.4136.4137.sendpatchset@w520>
Message-ID: <20131003034712.GG28463@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:13:16PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Tie in the APMU SMP code on r8a7791. When used together
> with the secondary CPU device node and smp_ops in the
> board specific code then this will allow use of the
> two Cortex-A15 cores in the r8a7791 SoC.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/Makefile               |    1 
>  arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 
>  arch/arm/mach-shmobile/setup-r8a7791.c        |    1 
>  arch/arm/mach-shmobile/smp-r8a7791.c          |   62 +++++++++++++++++++++++++
>  4 files changed, 65 insertions(+)

Thanks, I have queued this up in the soc3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The soc3 branch includes soc code previously queued up for v3.13
and a merge with renesas-smp-for-v3.13 which I sent a pull request for
a few days ago. The reason for the merge is to reduce conflicts.
