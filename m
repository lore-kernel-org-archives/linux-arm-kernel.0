From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 22 Feb 2018 13:17:32 +0000
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <63e4b545-c6e5-f4b4-3ba1-cf7a142b64ec@huawei.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-3-git-send-email-xieyisheng1@huawei.com>
 <63e4b545-c6e5-f4b4-3ba1-cf7a142b64ec@huawei.com>
Message-ID: <3ff6fedc-d0c3-23a3-f1be-03b84f72a43c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/18 09:03, Yisheng Xie wrote:
[...]
>> +		/* Is it already bound to this device? */
>> +		list_for_each_entry(tmp, &io_mm->devices, mm_head) {
>> +			if (tmp->dev != dev)
>> +				continue;
>> +
>> +			bond = tmp;
>> +			refcount_inc(&bond->refs);
>> +			io_mm_put_locked(io_mm);
> 
> Should io_mm->pasid still be set to *pasid when the device already bond? so driver can
> always get the right pasid if it bond to a mm multi-times, without keeping the pasid itself?

(Assuming you mean set *pasid = io_mm->pasid) I think it should, I seem to
have removed it by accident from this version

Thanks,
Jean
