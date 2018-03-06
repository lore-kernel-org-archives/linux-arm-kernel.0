From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Tue, 06 Mar 2018 07:52:37 -0500
Subject: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <430e9754-4cf7-0aa8-7899-fc13e6a2e079@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
 <77afa195-4842-a112-eba5-409b861b5315@codeaurora.org>
 <430e9754-4cf7-0aa8-7899-fc13e6a2e079@arm.com>
Message-ID: <93dc46c9f4c9f5f6f9dc50c26333398b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-06 05:46, Jean-Philippe Brucker wrote:
> On 05/03/18 21:53, Sinan Kaya wrote:
>> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>>> +static struct workqueue_struct *iommu_fault_queue;
>> 
>> Is there anyway we can make this fault queue per struct device?
>> Since this is common code, I think it needs some care.
> 
> I don't think it's better, the workqueue struct seems large. Maybe 
> having
> one wq per IOMMU is a good compromise?

Yes, one per iommu sounds reasonable.


As said in my other reply for this
> patch, doing so isn't completely straightforward. I'll consider adding 
> an
> iommu pointer to the iommu_param struct attached to each device.
> 
> Thanks,
> Jean
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
