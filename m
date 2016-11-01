From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2016 17:18:33 +0000
Subject: [RFC v2 2/7] arm: Use generic VDSO unmap and remap
In-Reply-To: <20161101171101.24704-2-cov@codeaurora.org>
References: <20161101171101.24704-1-cov@codeaurora.org>
 <20161101171101.24704-2-cov@codeaurora.org>
Message-ID: <20161101171833.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You know, on its own, this patch is totally meaningless.  Sorry, there's
nothing more I can say about this.

On Tue, Nov 01, 2016 at 11:10:56AM -0600, Christopher Covington wrote:
> Checkpoint/Restore In Userspace (CRIU) needs to be able to unmap and remap
> the VDSO to successfully checkpoint and restore applications in the face of
> changing VDSO addresses due to Address Space Layout Randomization (ASLR,
> randmaps). Previously, this was implemented in architecture-specific code
> for PowerPC and x86. However, a generic version based on Laurent Dufour's
> PowerPC implementation is now available, so begin using it on ARM.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm/mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index c1799dd..1d3312b 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -845,6 +845,7 @@ config VDSO
>  	depends on AEABI && MMU && CPU_V7
>  	default y if ARM_ARCH_TIMER
>  	select GENERIC_TIME_VSYSCALL
> +	select GENERIC_VDSO
>  	help
>  	  Place in the process address space an ELF shared object
>  	  providing fast implementations of gettimeofday and
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
