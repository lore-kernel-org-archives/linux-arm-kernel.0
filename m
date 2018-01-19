From: jcm@jonmasters.org (Jon Masters)
Date: Fri, 19 Jan 2018 14:08:56 -0500
Subject: [PATCH v3 1/2] arm64: Branch predictor hardening for Cavium
 ThunderX2
In-Reply-To: <1516364568-95577-1-git-send-email-jnair@caviumnetworks.com>
References: <20180118135354.GB20783@arm.com>
 <1516364568-95577-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <9be02a5d-7d2d-7c61-e593-056be65ff26b@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2018 07:22 AM, Jayachandran C wrote:
> Use PSCI based mitigation for speculative execution attacks targeting
> the branch predictor. We use the same mechanism as the one used for
> Cortex-A CPUs, we expect the PSCI version call to have a side effect
> of clearing the BTBs.
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 70e5f18..45ff9a2 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -338,6 +338,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
>  		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
>  	},
> +	{
> +		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> +		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
> +		.enable = enable_psci_bp_hardening,
> +	},
> +	{
> +		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> +		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
> +		.enable = enable_psci_bp_hardening,
> +	},
>  #endif
>  	{
>  	}
> 

Both of these patches seem reasonable to me.
