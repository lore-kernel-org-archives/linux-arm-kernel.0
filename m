From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 6 Mar 2018 10:37:10 +0000
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <27a044ee-0ed7-0470-0fef-289d0d5cf5e8@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <27a044ee-0ed7-0470-0fef-289d0d5cf5e8@codeaurora.org>
Message-ID: <83f46f73-baa7-c3d5-86f0-cf0af05ab359@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/18 15:28, Sinan Kaya wrote:
> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>> +static void io_mm_free(struct io_mm *io_mm)
>> +{
>> +	struct mm_struct *mm;
>> +	void (*release)(struct io_mm *);
>> +
>> +	release = io_mm->release;
>> +	mm = io_mm->mm;
>> +
>> +	release(io_mm);
> 
> Is there any reason why you can't call iommu->release()
> here directly? Why do you need the release local variable?

I think I can remove the local variable

Thanks,
Jean
