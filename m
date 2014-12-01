From: schwab@linux-m68k.org (Andreas Schwab)
Date: Mon, 01 Dec 2014 21:39:18 +0100
Subject: [PATCH 5/7] iommu/arm-smmu: don't bother truncating the s1 output
 size to VA_BITS
In-Reply-To: <1409849405-17347-6-git-send-email-will.deacon@arm.com> (Will
 Deacon's message of "Thu, 4 Sep 2014 17:50:03 +0100")
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
 <1409849405-17347-6-git-send-email-will.deacon@arm.com>
Message-ID: <87mw77cdft.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ecad700cd4f4..2a7e3331b93a 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -24,7 +24,7 @@
>   *	- v7/v8 long-descriptor format
>   *	- Non-secure access to the SMMU
>   *	- 4k and 64k pages, with contiguous pte hints.
> - *	- Up to 42-bit addressing (dependent on VA_BITS)
> + *	- Up to 48-bit addressing (dependent on VA_BITS)

Does that mean that the dependency on !ARM_SMMU for ARM64_VA_BITS_48 is
obsolete?

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
