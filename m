From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 14 Mar 2018 13:08:15 +0000
Subject: [PATCH 17/37] iommu/arm-smmu-v3: Move context descriptor code
In-Reply-To: <20180309124445.00005e08@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-18-jean-philippe.brucker@arm.com>
 <20180309124445.00005e08@huawei.com>
Message-ID: <04ae7f27-08b3-47c1-3d62-6dcc1fe79c1f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/18 11:44, Jonathan Cameron wrote:
> On Mon, 12 Feb 2018 18:33:32 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> In order to add support for substream ID, move the context descriptor code
>> into a separate library. At the moment it only manages context descriptor
>> 0, which is used for non-PASID translations.
>>
>> One important behavior change is the ASID allocator, which is now global
>> instead of per-SMMU. If we end up needing per-SMMU ASIDs after all, it
>> would be relatively simple to move back to per-device allocator instead
>> of a global one. Sharing ASIDs will require an IDR, so implement the
>> ASID allocator with an IDA instead of porting the bitmap, to ease the
>> transition.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Hi Jean-Philippe,
> 
> This would have been easier to review if split into a 'move' and additional
> patches actually making the changes described.
> 
> Superficially it looks like there may be more going on in here than the
> above description suggests.  I'm unsure why we are gaining 
> the CFGI_CD_ALL and similar in this patch as there is just to much going on.

Ok I'll try to split this

Thanks,
Jean
