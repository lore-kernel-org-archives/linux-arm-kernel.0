From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 12 Sep 2017 16:51:43 +0100
Subject: [RFC PATCH 4/4] ACPI: IORT: Add SMMUv3 MSI support
In-Reply-To: <96c8b5d8-eff2-6583-04da-cb3fdab8e6cb@linaro.org>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
 <1502276017-63108-5-git-send-email-guohanjun@huawei.com>
 <20170811093348.GC26039@red-moon>
 <CAGHbJ3AgEvbpsPdeqJ+bFWa5hBMqxBX6g1eC4HiUvHarJf8H+g@mail.gmail.com>
 <20170815171525.GB13707@e107981-lin.cambridge.arm.com>
 <de1b88e0-57d5-b73b-bc49-3c28070df6b1@linaro.org>
 <20170817130139.GA17795@red-moon>
 <96c8b5d8-eff2-6583-04da-cb3fdab8e6cb@linaro.org>
Message-ID: <20170912155143.GA29684@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 12, 2017 at 11:27:13AM +0800, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 2017/8/17 21:01, Lorenzo Pieralisi wrote:
> >On Thu, Aug 17, 2017 at 03:49:37PM +0800, Hanjun Guo wrote:
> >
> >[...]
> >
> >>>  /**
> >>>   * iort_get_platform_device_domain() - Find MSI domain related to a
> >>>   * platform device
> >>>@@ -1159,6 +1207,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
> >>>  	/* Configure DMA for the page table walker */
> >>>  	acpi_dma_configure(&pdev->dev, attr);
> >>>+	iort_set_device_domain(&pdev->dev, node);
> >>
> >>This is fine to me, but I think we still need to retrieve
> >>the output ID as the request id for ITS, which means we
> >>need to do that in iort_pmsi_get_dev_id(), right?
> >
> >Yes, probably we can add code there like:
> >
> >ret = iort_get_id_mapping_index(&index);
> >if (!ret)
> >	iort_node_get_id(node, &id, index);
> >	...
> >
> >This requires updating iort_node_get_id() to allow single mappings
> >for SMMU/PMCG as you flagged up before.
> >
> >I will think a bit more to see if there is a cleaner way to reshuffle
> >the mapping API.
> 
> I would like to send a updated version after the merge window to gather
> more comments, and at the same time we can work on the cleaner way to
> reshuffle the mapping API, what do you thing?

I think you should send an updated patch at -rc1 with comments above, we
can rework the API later or I can do it on top of your patches for the
upcoming merge window.

Thanks !
Lorenzo
