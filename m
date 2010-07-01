From: zpfeffer@codeaurora.org (Zach Pfeffer)
Date: Thu, 01 Jul 2010 00:16:18 -0700
Subject: [RFC 1/3] mm: iommu: An API to unify IOMMU, CPU and device memory
	management
In-Reply-To: <20100630164058.aa6aa3a2.randy.dunlap@oracle.com>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<20100630164058.aa6aa3a2.randy.dunlap@oracle.com>
Message-ID: <4C2C40C2.50106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for the corrections. I'm correcting them now. Some responses:

Randy Dunlap wrote:
>> +    struct vcm *vcm_create(size_t start_addr, size_t len);
> 
> Seems odd to use size_t for start_addr.

I used size_t because I wanted to allow the start_addr the same range
as len. Is there a better type to use? I see 'unsigned long' used
throughout the mm code. Perhaps that's better for both the start_addr
and len.


>> +A Reservation is created and destroyed with:
>> +
>> +    struct res *vcm_reserve(struct vcm *vcm, size_t len, uint32_t attr);
> 
> s/uint32_t/u32/ ?

Sure.


>> +    Associate and activate all three to their respective devices:
>> +
>> +        avcm_iommu = vcm_assoc(vcm_iommu, dev_iommu, attr0);
>> +        avcm_onetoone = vcm_assoc(vcm_onetoone, dev_onetoone, attr1);
>> +        avcm_vmm = vcm_assoc(vcm_vmm, dev_cpu, attr2);
> 
> error handling on vcm_assoc() failures?

I'll add the deassociate call to the example.


>> +        res_iommu = vcm_reserve(vcm_iommu, SZ_2MB + SZ_4K, attr);
>> +        res_onetoone = vcm_reserve(vcm_onetoone, SZ_2MB + SZ_4K, attr);
>> +        res_vmm = vcm_reserve(vcm_vmm, SZ_2MB + SZ_4K, attr);
> 
> error handling?

I'll add it here too.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
