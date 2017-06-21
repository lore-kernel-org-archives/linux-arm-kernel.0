From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 21 Jun 2017 20:19:47 +0200
Subject: [PATCH v8 3/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #126
In-Reply-To: <1497968259-16390-4-git-send-email-gakula@caviumnetworks.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
 <1497968259-16390-4-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170621181947.GH16981@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.06.17 19:47:39, Geetha sowjanya wrote:
> From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> 
> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> lines for gerror, eventq and cmdq-sync.
> 
> SHARED_IRQ option is set as a errata workaround, which allows to share the irq
> line by register single irq handler for all the interrupts.

I found the entry in silicon-errata.txt missing, is that on purpose?

-Robert

> 
> Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    5 ++
>  drivers/iommu/arm-smmu-v3.c                        |   73 ++++++++++++++++----
>  2 files changed, 64 insertions(+), 14 deletions(-)
