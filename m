From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 5 Jan 2016 11:50:19 +0800
Subject: [PATCH v3 47/62] arm/p2m: Add helper functions to map memory
 regions
In-Reply-To: <565C69A7.1020806@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-48-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511271203460.8984@kaball.uk.xensource.com>
 <565C69A7.1020806@citrix.com>
Message-ID: <568B3D7B.3070901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/30 23:22, Julien Grall wrote:
> Hi,
> 
> On 27/11/15 12:04, Stefano Stabellini wrote:
>> > On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
>>> >> From: Parth Dixit <parth.dixit@linaro.org>
>>> >>
>>> >> Create a helper function for mapping with cached attributes.
>>> >>
>>> >> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
>>> >> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> > 
>> > You might be able to use the existing guest_physmap_add_entry and
>> > guest_physmap_remove_page for your purposes.
> I would rather avoid to do that, those function use the type p2m_ram_rw
> which imply the memory is executable.

It could pass the type p2m_mmio_direct or p2m_ram_ro to
guest_physmap_add_entry, right?

Thanks,
-- 
Shannon
