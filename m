From: eric.auger@redhat.com (Auger Eric)
Date: Sun, 8 Jan 2017 17:26:53 +0100
Subject: [PATCH v6 07/18] iommu: Implement reserved_regions iommu-group
 sysfs file
In-Reply-To: <0858b719-2888-0645-66d2-56fe698f4e2f@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-8-git-send-email-eric.auger@redhat.com>
 <20170106110039.GL17255@8bytes.org>
 <888d3750-817c-77d1-8154-e77cf8c3ad4b@redhat.com>
 <20170106124816.GQ17255@8bytes.org>
 <0858b719-2888-0645-66d2-56fe698f4e2f@redhat.com>
Message-ID: <24abe958-6a79-5766-653b-b355a85f2be4@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/01/2017 18:18, Auger Eric wrote:
> Hi Joerg, Robin,
> 
> On 06/01/2017 13:48, Joerg Roedel wrote:
>> On Fri, Jan 06, 2017 at 12:46:05PM +0100, Auger Eric wrote:
>>> On 06/01/2017 12:00, Joerg Roedel wrote:
>>
>>>> I think it also makes sense to report the type of the reserved region.
>>>
>>> What is the best practice in that case? Shall we put the type enum
>>> values as strings such as:
>>> - direct
>>> - nomap
>>> - msi
>>>
>>> and document that in Documentation/ABI/testing/sysfs-kernel-iommu_groups
>>
>> Yes, a string would be good. An probably 'reserved' is a better name
>> than nomap?
> the iommu_insert_resv_region() function that builds the group reserved
> region list sorts all regions and handles the case where there is an
> overlap between regions. Current code does not care about the type of
> regions. So in case a NOMAP region overlaps with a direct-mapped region,
> what is reported to the user space is the superset and the type depends
> on the overlap. This was suggested by Robin at some point to handle
> overlaps.
> 
> I guess I should merge regions only in case the types equal?
> 
> I remember that Alex thought that user-space should not care so much
> about the type of the regions so I tought it was better for the
> user-space to have a minimal view of the regions.
> 
> On the other hand, this issue of merging regions of different types
> should not happen often but I prefer to highlight the potential issue.

> 
> What is your guidance?

Please forget the question. From an API point of view It does not make
sense that iommu_insert_resv_region() merges regions of a different
types since the type field becomes unreliable. I will fix this.

Thanks

Eric
> 
> Thanks
> 
> Eric
>>
>>
>> 	Joerg
>>
