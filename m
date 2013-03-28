From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 28 Mar 2013 13:48:09 +0000
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
Message-ID: <20130328134808.GD16765@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Mar 25, 2013 at 04:41:52PM +0000, Nicolas Pitre wrote:
> 
> Russell, would you please pull the following:
> 
> 	git://git.linaro.org/people/nico/linux mcpm
> 
> This contains the basic infrastructure needed to support CPU hotplug, 
> deep CPU idle and secondary CPU bringup in a cluster based system such 
> as, but not limited to, those based on the big.LITTLE architecture.

Can I ask you please what's your plan for merging this series ?
We have lots of code in our trees that depends on this set (which has been
extensively tested), hence I am really looking forward to having a stable
branch to rebase on top.

Thank you very much,
Lorenzo

> 
> This is the same set of patches from the previous pull request that 
> missed thelast merge window, except for minor changes needed for this 
> code to work with v3.9-rc3 (i.e. removal of the __cpuinit tags and 
> removal of set_smp_cross_call() from the smp_init_cpus method).
> 
> The diffstat follows:
> 
>  Documentation/arm/cluster-pm-race-avoidance.txt | 498 ++++++++++++++++++
>  Documentation/arm/vlocks.txt                    | 211 ++++++++
>  arch/arm/Kconfig                                |   8 +
>  arch/arm/common/Makefile                        |   1 +
>  arch/arm/common/mcpm_entry.c                    | 314 +++++++++++
>  arch/arm/common/mcpm_head.S                     | 219 ++++++++
>  arch/arm/common/mcpm_platsmp.c                  |  87 +++
>  arch/arm/common/vlock.S                         | 108 ++++
>  arch/arm/common/vlock.h                         |  29 +
>  arch/arm/include/asm/mcpm_entry.h               | 190 +++++++
>  10 files changed, 1665 insertions(+)
> 
> 
> Nicolas
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
