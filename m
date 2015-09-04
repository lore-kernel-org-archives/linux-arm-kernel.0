From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 04 Sep 2015 13:00:10 +0100
Subject: [PATCH 1/3] arm64/cpufeature.h: Add macros for a cpu features
 testing
In-Reply-To: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
References: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <55E987CA.4090302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/15 19:11, Alexander Kuleshov wrote:
> This patch provides a couple of macros for the testing of processor
> features (crypto and FP/SIMD) like support of SHA1, AES instructions,
> support for FPU and etc. There is already a couple of places in the
> arch/arm64/kernel where these processor features are tested and these
> macros are facilitate this.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>   arch/arm64/include/asm/cpufeature.h | 44 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index c104421..2919455 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -28,7 +28,50 @@
>
>   #define ARM64_NCAPS				4
>
> +/*
> + * ID_AA64ISAR0_EL1 AES, bits [7:4]
> + */
> +#define ID_AA64ISAR0_EL1_AES_MASK	4
> +#define ID_AA64ISAR0_EL1_AES(feature)	\
> +	(((feature >> ID_AA64ISAR0_EL1_AES_MASK) & 0xf) & 1UL)
> +#define ID_AA64ISAR0_EL1_PMULL(feature)	\
> +	(((feature >> ID_AA64ISAR0_EL1_AES_MASK) & 0xf) & 2UL)
> +


There is generic CPUID feature helper queued for 4.3, which can extract
the feature bits

  cpuid_feature_extract_field(feature, shift)

You might want to use it instead. Btw, I have a patch series(waiting for
the merge window, before I post), which changes the way we initialise the
HWCAP bits.

Thanks
Suzuki
