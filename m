From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 6 Jan 2017 12:12:20 +0000
Subject: [PATCH v6 01/18] iommu/dma: Allow MSI-only cookies
In-Reply-To: <b058a7f9-84bf-1d5c-1c24-24da251cc964@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-2-git-send-email-eric.auger@redhat.com>
 <20170106105945.GK17255@8bytes.org>
 <b058a7f9-84bf-1d5c-1c24-24da251cc964@redhat.com>
Message-ID: <ae222579-6939-b89a-80c2-9ee8f147299e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 11:46, Auger Eric wrote:
> 
> 
> On 06/01/2017 11:59, Joerg Roedel wrote:
>> On Thu, Jan 05, 2017 at 07:04:29PM +0000, Eric Auger wrote:
>>>  struct iommu_dma_cookie {
>>> -	struct iova_domain	iovad;
>>> -	struct list_head	msi_page_list;
>>> -	spinlock_t		msi_lock;
>>> +	union {
>>> +		struct iova_domain	iovad;
>>> +		dma_addr_t		msi_iova;
>>> +	};
>>> +	struct list_head		msi_page_list;
>>> +	spinlock_t			msi_lock;
>>> +	enum iommu_dma_cookie_type	type;
>>
>> Please move the type to the beginning of the struct and add a comment
>> how the type relates to the union.
> 
> Sure
> 
> Thank you for the review.

FWIW I already had a cleaned up version of this patch, I just hadn't
mentioned it. I've pushed out an update with that change added too[1].

Robin.

[1]:http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/misc

> 
> Best regards
> 
> Eric
>>
>>
>>
>> 	Joerg
>>
