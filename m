From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 3 Apr 2018 13:34:34 +0100
Subject: [kvmtool PATCH 20/17] kvmtool: arm64: Switch memory layout
In-Reply-To: <1522156531-28348-21-git-send-email-suzuki.poulose@arm.com>
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
 <1522156531-28348-21-git-send-email-suzuki.poulose@arm.com>
Message-ID: <f04a9ac7-a555-47e1-0bef-f5ff28b287f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 27/03/18 14:15, Suzuki K Poulose wrote:
> If the guest wants to use a larger physical address space place
> the RAM at upper half of the address space. Otherwise, it uses the
> default layout.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arm/aarch32/include/kvm/kvm-arch.h |  1 +
>  arm/aarch64/include/kvm/kvm-arch.h | 15 ++++++++++++---
>  arm/include/arm-common/kvm-arch.h  | 11 ++++++-----
>  arm/kvm.c                          |  2 +-
>  4 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
> index cd31e72..2d62aab 100644
> --- a/arm/aarch32/include/kvm/kvm-arch.h
> +++ b/arm/aarch32/include/kvm/kvm-arch.h
> @@ -4,6 +4,7 @@
>  #define ARM_KERN_OFFSET(...)	0x8000
>  
>  #define ARM_MAX_MEMORY(...)	ARM_LOMAP_MAX_MEMORY

I guess this should now be ARM32_MAX_MEMORY?

Thanks,
Jean
