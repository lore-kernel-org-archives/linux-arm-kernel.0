From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 11 Sep 2014 13:55:56 +0100
Subject: [PATCH v3 0/3] xen/arm: fix "xen_add_mach_to_phys_entry: cannot
 add" problem
In-Reply-To: <alpine.DEB.2.02.1409102335490.8137@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1408011552460.2293@kaball.uk.xensource.com>
 <53DBB231.5010900@citrix.com>
 <alpine.DEB.2.02.1409102335490.8137@kaball.uk.xensource.com>
Message-ID: <54119BDC.4080402@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/14 00:28, Stefano Stabellini wrote:
> On Fri, 1 Aug 2014, David Vrabel wrote:
>> On 01/08/14 15:55, Stefano Stabellini wrote:
>>> Hi all,
>>> Xen support in Linux for ARM and ARM64 suffers from lack of support for
>>> multiple mfn to pfn mappings: whenever a frontend grants the same page
>>> multiple times to the backend, the mfn to pfn accounting in
>>> arch/arm/xen/p2m.c fails. The issue has become critical since v3.15,
>>> when xen-netfront/xen-netback switched from grant copies to grant
>>> mappings, therefore causing the issue to happen much more often.
>>>
>>> Fixing the mfn to pfn accounting in p2m.c is difficult and expensive,
>>> therefore we are looking for alternative solutions. One idea is avoiding
>>> mfn to pfn conversions altogether. The only code path that needs them is
>>> swiotlb-xen:unmap_page (and single_for_cpu and single_for_device).
>>>
>>> To avoid mfn to pfn conversions we rely on a second p2m mapping done by
>>> Xen (a separate patch series will be sent for Xen). In Linux we use it
>>> to perform the cache maintenance operations without mfns conversions.
>>>
>>>
>>> The Xen side patch series that introduces XENFEAT_grant_map_identity is:
>>> http://marc.info/?l=xen-devel&m=140690433923855
>>
>> If the Xen side is in master, you can apply this series to
>> devel/for-linus-3.17
> 
> The Xen side patch finally went in. Unfortunately it's probably too late
> for 3.17.

Isn't this a bug fix?  I think would be fine to go into 3.17.

David
