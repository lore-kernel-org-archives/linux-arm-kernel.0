From: eric.auger@redhat.com (Auger Eric)
Date: Fri, 6 Jan 2017 12:46:05 +0100
Subject: [PATCH v6 07/18] iommu: Implement reserved_regions iommu-group
 sysfs file
In-Reply-To: <20170106110039.GL17255@8bytes.org>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-8-git-send-email-eric.auger@redhat.com>
 <20170106110039.GL17255@8bytes.org>
Message-ID: <888d3750-817c-77d1-8154-e77cf8c3ad4b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 06/01/2017 12:00, Joerg Roedel wrote:
> On Thu, Jan 05, 2017 at 07:04:35PM +0000, Eric Auger wrote:
>> +	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
>> +		str += sprintf(str, "0x%016llx 0x%016llx\n",
>> +			       (long long int)region->start,
>> +			       (long long int)(region->start +
>> +						region->length - 1));
>> +		kfree(region);
>> +	}
> 
> I think it also makes sense to report the type of the reserved region.

What is the best practice in that case? Shall we put the type enum
values as strings such as:
- direct
- nomap
- msi

and document that in Documentation/ABI/testing/sysfs-kernel-iommu_groups

Thanks

Eric
> 
> 
> 
> 	Joerg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
