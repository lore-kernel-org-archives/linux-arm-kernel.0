From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 17:24:16 -0500
Subject: [PATCH v8 1/5] Doc: iommu/arm-smmu-v3: Add workaround for
 HiSilicon erratum 161010801
In-Reply-To: <20170927133241.21036-2-shameerali.kolothum.thodi@huawei.com>
References: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
 <20170927133241.21036-2-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20171005222416.zrrzwd3lmxccwodo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 02:32:37PM +0100, Shameer Kolothum wrote:
> From: John Garry <john.garry@huawei.com>
> 
> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> platforms hip06/hip07 to support the SMMU mappings for MSI transactions.
> 
> On these platforms, GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> 
> This patch adds a compatible string to implement this errata for
> HiSilicon Hi161x SMMUv3 model on hip06/hip07 platforms.
> 
> Also, the arm64 silicon errata is updated with this same erratum.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> [Shameer: Modified to use compatible string for errata]
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  Documentation/arm64/silicon-errata.txt                  | 1 +
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
