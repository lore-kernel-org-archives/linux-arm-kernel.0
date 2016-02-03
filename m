From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Feb 2016 14:06:33 +0000
Subject: [PATCH 4/4] arm64: Rename cpuid_feature field extract routines
In-Reply-To: <1453805896-4397-5-git-send-email-suzuki.poulose@arm.com>
References: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
 <1453805896-4397-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160203140632.GB16727@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 10:58:16AM +0000, Suzuki K. Poulose wrote:
> Now that we have a clear understanding of the sign of a feature,
> rename the routines to reflect the sign, so that it is not misused.
> The cpuid_feature_extract_field() now accepts a 'sign' parameter.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
[...]
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 7364339..2ac4a22 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -307,7 +307,7 @@ static inline unsigned int kvm_get_vmid_bits(void)
>  {
>  	int reg = read_system_reg(SYS_ID_AA64MMFR1_EL1);
>  
> -	return (cpuid_feature_extract_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
> +	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
>  }

Since this is touch a KVM file, it would be good to have an ack from
Marc or Christoffer.

Thanks.

-- 
Catalin
