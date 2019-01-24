Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE58C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:31:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A00421872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eMH37pMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A00421872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5j54Z70JkzkvQw5PZAxtO9QJ0cNjoBNwIq+qX89kpbI=; b=eMH37pMgIfq4OAyUc6Gc+DAXi
	dB4F91GTJjHMSyzSnNCB2nbs4GL2zkQRqVpbNv44RY8Az41JbkyxMJKMnDGTTyWcNNHGNwRG7wYYZ
	Ev7ckb5b4kar5IF40IYWIUZNJGCZiobKqr5s0WvZNv3Wt771zR0GpI9fdiXZCpY2AM8wPKwr4KHxb
	4KSSDmEJOseVrnf272Pp7BWqmpvpqqyTWTTJqCMzSIxlJoawLbRCdlzIvicgN8biRcEsiUiM6gDN7
	m96b1gY/OHpGEgISXfGyhQJ5yDdEE8Tkbp6pwAu839zJdS8MS5C/MEwuvjMQ2eiAXTxJ/8lmS+ZD1
	E7JndgSeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiqj-0005QG-FQ; Thu, 24 Jan 2019 17:31:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiqf-0005Pr-80
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 17:31:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C8A3A78;
 Thu, 24 Jan 2019 09:31:27 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07633F5AF;
 Thu, 24 Jan 2019 09:31:24 -0800 (PST)
Subject: Re: [PATCH v5 1/4] acpi: arm64: add iort support for PMCG
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 lorenzo.pieralisi@arm.com
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-2-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0f7d81a3-58d3-b7c9-cf72-0583191fa536@arm.com>
Date: Thu, 24 Jan 2019 17:31:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130154751.28580-2-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_093129_297104_5AC0AF25 
X-CRM114-Status: GOOD (  25.06  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, vkilari@codeaurora.org, neil.m.leeder@gmail.com,
 jean-philippe.brucker@arm.com, pabba@codeaurora.org, john.garry@huawei.com,
 will.deacon@arm.com, rruigrok@codeaurora.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30/11/2018 15:47, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Add support for the SMMU Performance Monitor Counter Group
> information from ACPI. This is in preparation for its use
> in the SMMUv3 PMU driver.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 97 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 76 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 2a361e2..2da08e1 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -356,7 +356,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>   	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>   		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> -		    node->type == ACPI_IORT_NODE_SMMU_V3) {
> +		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> +		    node->type == ACPI_IORT_NODE_PMCG) {
>   			*id_out = map->output_base;
>   			return parent;
>   		}
> @@ -394,6 +395,8 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>   		}
>   
>   		return smmu->id_mapping_index;
> +	case ACPI_IORT_NODE_PMCG:
> +		return 0;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1216,14 +1219,23 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>   	}
>   }
>   
> -static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
> +static void __init arm_smmu_v3_dma_configure(struct device *dev,
> +					     struct acpi_iort_node *node)
>   {
>   	struct acpi_iort_smmu_v3 *smmu;
> +	enum dev_dma_attr attr;
>   
>   	/* Retrieve SMMUv3 specific data */
>   	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>   
> -	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
> +	attr = (smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE) ?
> +			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> +
> +	/* We expect the dma masks to be equivalent for all SMMUv3 set-ups */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/* Configure DMA for the page table walker */
> +	acpi_dma_configure(dev, attr);
>   }
>   
>   #if defined(CONFIG_ACPI_NUMA)
> @@ -1299,20 +1311,64 @@ static void __init arm_smmu_init_resources(struct resource *res,
>   	}
>   }
>   
> -static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
> +static void __init arm_smmu_dma_configure(struct device *dev,
> +					  struct acpi_iort_node *node)
>   {
>   	struct acpi_iort_smmu *smmu;
> +	enum dev_dma_attr attr;
>   
>   	/* Retrieve SMMU specific data */
>   	smmu = (struct acpi_iort_smmu *)node->node_data;
>   
> -	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
> +	attr = (smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK) ?
> +			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> +
> +	/* We expect the dma masks to be equivalent for SMMU set-ups */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/* Configure DMA for the page table walker */
> +	acpi_dma_configure(dev, attr);
> +}
> +
> +static int __init arm_smmu_v3_pmcg_count_resources(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	/*
> +	 * There are always 2 memory resources.
> +	 * If the overflow_gsiv is present then add that for a total of 3.
> +	 */
> +	return pmcg->overflow_gsiv ? 3 : 2;
> +}
> +
> +static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
> +					       struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	res[0].start = pmcg->page0_base_address;
> +	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[1].start = pmcg->page1_base_address;
> +	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
> +	res[1].flags = IORESOURCE_MEM;
> +
> +	if (pmcg->overflow_gsiv)
> +		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
> +				       ACPI_EDGE_SENSITIVE, &res[2]);
>   }
>   
>   struct iort_dev_config {
>   	const char *name;
>   	int (*dev_init)(struct acpi_iort_node *node);
> -	bool (*dev_is_coherent)(struct acpi_iort_node *node);
> +	void (*dev_dma_configure)(struct device *dev,
> +				    struct acpi_iort_node *node);
>   	int (*dev_count_resources)(struct acpi_iort_node *node);
>   	void (*dev_init_resources)(struct resource *res,
>   				     struct acpi_iort_node *node);
> @@ -1322,7 +1378,7 @@ struct iort_dev_config {
>   
>   static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
>   	.name = "arm-smmu-v3",
> -	.dev_is_coherent = arm_smmu_v3_is_coherent,
> +	.dev_dma_configure = arm_smmu_v3_dma_configure,
>   	.dev_count_resources = arm_smmu_v3_count_resources,
>   	.dev_init_resources = arm_smmu_v3_init_resources,
>   	.dev_set_proximity = arm_smmu_v3_set_proximity,
> @@ -1330,19 +1386,28 @@ static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
>   
>   static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
>   	.name = "arm-smmu",
> -	.dev_is_coherent = arm_smmu_is_coherent,
> +	.dev_dma_configure = arm_smmu_dma_configure,
>   	.dev_count_resources = arm_smmu_count_resources,
> -	.dev_init_resources = arm_smmu_init_resources
> +	.dev_init_resources = arm_smmu_init_resources,
> +};
> +
> +static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
> +	.name = "arm-smmu-v3-pmu",

Nit: s/pmu/pmcg/ for consistency, I think.

> +	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
> +	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
>   };
>   
>   static __init const struct iort_dev_config *iort_get_dev_cfg(
>   			struct acpi_iort_node *node)
>   {
> +

Nit: spurious newline.

Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	switch (node->type) {
>   	case ACPI_IORT_NODE_SMMU_V3:
>   		return &iort_arm_smmu_v3_cfg;
>   	case ACPI_IORT_NODE_SMMU:
>   		return &iort_arm_smmu_cfg;
> +	case ACPI_IORT_NODE_PMCG:
> +		return &iort_arm_smmu_v3_pmcg_cfg;
>   	default:
>   		return NULL;
>   	}
> @@ -1360,7 +1425,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   	struct fwnode_handle *fwnode;
>   	struct platform_device *pdev;
>   	struct resource *r;
> -	enum dev_dma_attr attr;
>   	int ret, count;
>   
>   	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
> @@ -1398,12 +1462,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   	if (ret)
>   		goto dev_put;
>   
> -	/*
> -	 * We expect the dma masks to be equivalent for
> -	 * all SMMUs set-ups
> -	 */
> -	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> -
>   	fwnode = iort_get_fwnode(node);
>   
>   	if (!fwnode) {
> @@ -1413,11 +1471,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   
>   	pdev->dev.fwnode = fwnode;
>   
> -	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> -			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> -
> -	/* Configure DMA for the page table walker */
> -	acpi_dma_configure(&pdev->dev, attr);
> +	if (ops->dev_dma_configure)
> +		ops->dev_dma_configure(&pdev->dev, node);
>   
>   	iort_set_device_domain(&pdev->dev, node);
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
