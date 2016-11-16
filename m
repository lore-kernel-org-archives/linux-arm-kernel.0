From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Nov 2016 18:11:34 +0000
Subject: [PATCH v3 0/2] arm64: Support systems without FP/ASIMD
In-Reply-To: <1478613381-5718-1-git-send-email-suzuki.poulose@arm.com>
References: <1478613381-5718-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20161116181133.GC3224@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 01:56:19PM +0000, Suzuki K. Poulose wrote:
> This series adds supports to the kernel and KVM hyp to handle
> systems without FP/ASIMD properly. At the moment the kernel
> doesn't check if the FP unit is available before accessing
> the registers (e.g during context switch). Also for KVM,
> we trap the FP/ASIMD accesses and handle it by injecting an
> undefined instruction into the VM on systems without FP.
> 
> Tested on a FVP_Base-AEM-v8A model by disabling VFP on at
> least one CPU ( -C clusterX.cpuY.vfp-present=0 ).
> 
> Changes since V2:
>  - Dropped cleanup patch for arm64/crypto/aes-ce-ccm-glue.c
>  - Removed static_key check from cpus_have_cap. All users with
>    constant caps should use the new API to make use of static_keys.
>  - Removed a dedicated static_key used in irqchip-gic-v3.c for
>    Cavium errata with the new API.
> 
> Applies on v4.9-rc4 + [1] (which is pushed for rc5)
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=147819889813214&w=2

I queued the patches for 4.10 with a slight modification as I haven't
cherry-picked the patch above. I'll push the for-next/core branch out
once I've done some testing.

Thanks.

-- 
Catalin
