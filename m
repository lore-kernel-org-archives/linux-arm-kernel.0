From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 18 Apr 2016 10:20:46 +0800
Subject: [RFC 3/3] iommu: dma-iommu: use common implementation also on
 ARM architecture
In-Reply-To: <1455870164-25337-4-git-send-email-m.szyprowski@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
 <1455870164-25337-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5714447E.2030400@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?02?19? 16:22, Marek Szyprowski wrote:
> This patch replaces ARM-specific IOMMU-based DMA-mapping implementation
> with generic IOMMU DMA-mapping code shared with ARM64 architecture. The
> side-effect of this change is a switch from bitmap-based IO address space
> management to tree-based code. There should be no functional changes
> for drivers, which rely on initialization from generic arch_setup_dna_ops()
> interface. Code, which used old arm_iommu_* functions must be updated to
> new interface.
>
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
IOMMU works good on drm/rockchip ARM64 platform with this patch. So

Tested-by: Mark Yao <mark.yao@rock-chips.com>

Thanks.

-- 
?ark Yao
