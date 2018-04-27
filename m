From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Apr 2018 11:13:43 +0100
Subject: [PATCH] arm64: Add MIDR encoding for NVIDIA CPUs
In-Reply-To: <1524763925-13959-1-git-send-email-dgilhooley@nvidia.com>
References: <1524763925-13959-1-git-send-email-dgilhooley@nvidia.com>
Message-ID: <20180427101342.GA20014@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Apr 26, 2018 at 10:32:05AM -0700, David Gilhooley wrote:
> This patch adds the MIDR encodings for NVIDIA as well as
> the Denver and Carmel CPUs used in Tegra SoCs.
> 
> Signed-off-by: David Gilhooley <dgilhooley@nvidia.com>
> ---
>  arch/arm64/include/asm/cputype.h | 4 ++++
>  1 file changed, 4 insertions(+)

This looks fine to me, but it probably makes sense to merge this along with
some code that actually uses the definitions. I'm assuming you have some
workarounds that rely on this?

Will

> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 30014a9..df1d530 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -75,6 +75,7 @@
>  #define ARM_CPU_IMP_CAVIUM		0x43
>  #define ARM_CPU_IMP_BRCM		0x42
>  #define ARM_CPU_IMP_QCOM		0x51
> +#define ARM_CPU_IMP_NVIDIA		0x4E
>  
>  #define ARM_CPU_PART_AEM_V8		0xD0F
>  #define ARM_CPU_PART_FOUNDATION		0xD00
> @@ -99,6 +100,8 @@
>  #define QCOM_CPU_PART_FALKOR		0xC00
>  #define QCOM_CPU_PART_KRYO		0x200
>  
> +#define NVIDIA_CPU_PART_DENVER		0x003
> +#define NVIDIA_CPU_PART_CARMEL		0x004
> +
>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> @@ -114,6 +117,7 @@
>  #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
>  #define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
>  #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
> +#define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
> +#define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
>  
>  #ifndef __ASSEMBLY__
>  
> -- 
> 2.1.4
> 
