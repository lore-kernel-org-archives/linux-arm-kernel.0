From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 6 Mar 2018 10:46:36 +0000
Subject: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <77afa195-4842-a112-eba5-409b861b5315@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
 <77afa195-4842-a112-eba5-409b861b5315@codeaurora.org>
Message-ID: <430e9754-4cf7-0aa8-7899-fc13e6a2e079@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/18 21:53, Sinan Kaya wrote:
> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>> +static struct workqueue_struct *iommu_fault_queue;
> 
> Is there anyway we can make this fault queue per struct device?
> Since this is common code, I think it needs some care.

I don't think it's better, the workqueue struct seems large. Maybe having
one wq per IOMMU is a good compromise? As said in my other reply for this
patch, doing so isn't completely straightforward. I'll consider adding an
iommu pointer to the iommu_param struct attached to each device.

Thanks,
Jean
