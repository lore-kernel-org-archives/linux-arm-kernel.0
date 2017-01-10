From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Jan 2017 14:24:27 +0000
Subject: [PATCH v4 7/9] arm64: cpufeature: Track user visible fields
In-Reply-To: <1483982912-27215-8-git-send-email-suzuki.poulose@arm.com>
References: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
 <1483982912-27215-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170110142427.GA23051@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 05:28:30PM +0000, Suzuki K. Poulose wrote:
> Changes since V3:
>  - Mark ID_AA64ISAR0_EL1:RDM visible
[...]
>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA2_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA1_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_AES_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),

As I said in an earlier reply, I'd like the RDM exposing to come
together with a patch presenting the corresponding HWCAP bit. But it's
fine by me if you add the HWCAP separately from this patch, in which
case my ack still stands.

-- 
Catalin
