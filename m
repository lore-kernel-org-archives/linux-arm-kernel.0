From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:19:30 +0900
Subject: [PATCH 03/03] ARM: shmobile: Genmai support
In-Reply-To: <20130918201129.6319.80740.sendpatchset@w520>
References: <20130918201101.6319.97667.sendpatchset@w520>
 <20130918201129.6319.80740.sendpatchset@w520>
Message-ID: <20131003041929.GJ7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 05:11:29AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Genmai base board support making use of 128 MiB of memory,
> the r7s7211 SoC with the SCIF2 serial port and CA9 core.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/Makefile            |    1 
>  arch/arm/boot/dts/r7s72100-genmai.dts |   31 +++++++++++++++++++++++

Please consider adding the dts file in a separate patch next time.

>  arch/arm/mach-shmobile/Kconfig        |    5 +++
>  arch/arm/mach-shmobile/Makefile       |    1 
>  arch/arm/mach-shmobile/Makefile.boot  |    1 
>  arch/arm/mach-shmobile/board-genmai.c |   43 +++++++++++++++++++++++++++++++++
>  6 files changed, 82 insertions(+)

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The boards3 branch includes boards code previously queued up for v3.13
and a merge with soc changes previously queued up for v3.13. The reason
for the merge is to provide various build and run-time dependencies
including the r7s72100 SoC code which this board code uses.
