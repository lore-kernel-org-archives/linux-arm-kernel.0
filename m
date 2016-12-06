From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 6 Dec 2016 10:31:15 +0530
Subject: [RESEND PATCH V6 5/6] dmaengine: pl330: Make sure microcode is
 privileged
In-Reply-To: <1480690509-13490-6-git-send-email-sricharan@codeaurora.org>
References: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
 <1480690509-13490-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <20161206050115.GP6408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 08:25:08PM +0530, Sricharan R wrote:
> From: Mitchel Humpherys <mitchelh@codeaurora.org>
> 
> The PL330 performs privileged instruction fetches.  This can result in
> SMMU permission faults on SMMUs that implement the ARMv8 VMSA, which
> specifies that mappings that are writeable at one execution level shall
> not be executable at any higher-privileged level.  Fix this by using the
> DMA_ATTR_PRIVILEGED attribute, which will ensure that the microcode
> IOMMU mapping is only accessible to the privileged level.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
