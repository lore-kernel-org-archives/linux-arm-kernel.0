From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Dec 2009 17:23:06 +0000
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <1259084033-7283-2-git-send-email-saeed@marvell.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
Message-ID: <20091206172306.GA787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 07:33:51PM +0200, Saeed Bishara wrote:
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 9264d81..1549863 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -388,7 +388,7 @@ config CPU_FEROCEON_OLD_ID
>  
>  # ARMv6
>  config CPU_V6
> -	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> +	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE

Should I assume that the V6 processor is optional on Dove?  Does it run
without a processor present?  Probably not.

If so, then you don't want to append to this line - doing so makes the
option visible.  If your platform _always_ has a V6 processor, select
it just like everyone else does.

The only reason to extend that conditional is if a V6 processor is
to be optional.
