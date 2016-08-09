From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 9 Aug 2016 14:56:17 -0700
Subject: [RFCv2][PATCH 2/5] arm: Implement ARCH_HAS_FORCE_CACHE
In-Reply-To: <1470678577-14010-3-git-send-email-labbott@redhat.com>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
 <1470678577-14010-3-git-send-email-labbott@redhat.com>
Message-ID: <afd22029-c60c-1c15-3293-4011b085e07e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2016 10:49 AM, Laura Abbott wrote:
> arm may need the kernel_force_cache APIs to guarantee data consistency.
> Implement versions of these APIs based on the DMA APIs.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/arm/include/asm/cacheflush.h |   4 ++
>  arch/arm/mm/dma-mapping.c         | 119 --------------------------------------
>  arch/arm/mm/flush.c               | 115 ++++++++++++++++++++++++++++++++++++

Why is the code moved between dma-mapping.c and flush.c? It was not
obvious while looking at these patches why this is needed.
-- 
Florian
