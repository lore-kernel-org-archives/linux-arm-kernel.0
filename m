From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 5 Aug 2015 11:31:09 +0100
Subject: [PATCH v2 2/8] xen: Make clear that swiotlb and biomerge are
 dealing with DMA address
In-Reply-To: <alpine.DEB.2.02.1508051041060.11337@kaball.uk.xensource.com>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-3-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508051041060.11337@kaball.uk.xensource.com>
Message-ID: <55C1E5ED.10103@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 05/08/15 10:49, Stefano Stabellini wrote:
>>  /* VIRT <-> MACHINE conversion */
>>  #define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
>> @@ -96,7 +115,7 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
>>  
>>  bool xen_arch_need_swiotlb(struct device *dev,
>>  			   unsigned long pfn,
>> -			   unsigned long mfn);
>> +			   unsigned long dfn);
>>  unsigned long xen_get_swiotlb_free_pages(unsigned int order);
> 
> You missed a bunch of dfn->bfn renamings.

Sorry, I forgot to double check that before sending the patch. I will
fix it in the next version.

> Aside from those and the commit message error:
> 
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Thank you!

Regards,

-- 
Julien Grall
