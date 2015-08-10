From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 10 Aug 2015 12:24:20 +0100
Subject: [Xen-devel] [PATCH v3 09/20] xen/biomerge: Don't allow biovec
 to be merge when Linux is not using 4KB page
In-Reply-To: <alpine.DEB.2.02.1508101149070.11337@kaball.uk.xensource.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-10-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508101149070.11337@kaball.uk.xensource.com>
Message-ID: <55C889E4.8050307@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 10/08/15 11:50, Stefano Stabellini wrote:
> On Fri, 7 Aug 2015, Julien Grall wrote:
>> On ARM all dma-capable devices on a same platform may not be protected
>> by an IOMMU. The DMA requests have to use the BFN (i.e MFN on ARM) in
>> order to use correctly the device.
>>
>> While the DOM0 memory is allocated in a 1:1 fashion (PFN == MFN), grant
>> mapping will screw this contiguous mapping.
>>
>> When Linux is using 64KB page granularitary, the page may be split
>> accross multiple non-contiguous MFN (Xen is using 4KB page
>> granularity). Therefore a DMA request will likely fail.
>>
>> Checking that a 64KB page is using contiguous MFN is tedious. For
>> now, always says that biovec are not mergeable.
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> 
> Please fix the grammar in the subject line.

If I made a mistake it's unlikely that I will find myself which one I made.

Anyway, I guess you mean to replace merge by merged? I don't see any
other in the subject.

Regards,

-- 
Julien Grall
