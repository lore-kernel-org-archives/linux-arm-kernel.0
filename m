From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:13:27 +0000
Subject: [RFC 11/18] arm: msm: add ARCH_MSM_SCORPION to CPU_V7
In-Reply-To: <1263250057-26692-12-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-12-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100111231327.GG7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:30PM -0800, Daniel Walker wrote:
> From: Steve Muckle <smuckle@quicinc.com>
> 
> ARCH_MSM_SCORPION supports Qualcomm SnapDragon chipsets.
> 
> Signed-off-by: Steve Muckle <smuckle@quicinc.com>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> ---
>  arch/arm/mm/Kconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 155c7a3..c721880 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -409,7 +409,8 @@ config CPU_32v6K
>  
>  # ARMv7
>  config CPU_V7
> -	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> +	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_MSM_SCORPION
> +	default y if ARCH_MSM_SCORPION

You don't understand what's going on here.  You want to offer
the question "Support ARM V7 processor" to the user, and it's
acceptable on Scorpion to say "no" to this?

I think not.  Do it in the same way other platforms do it, and
select CPU_V7 from ARCH_MSM_SCORPION - if you have Scorpion, then
surely V7 CPU support is mandatory.

You only add to the 'if' line if the support is optional for your
platform.
