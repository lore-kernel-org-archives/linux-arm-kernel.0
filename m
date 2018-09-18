From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 18 Sep 2018 19:28:25 +0100
Subject: [PATCH v7 0/6] Add non-strict mode support for iommu-dma
In-Reply-To: <20180918171000.GI16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
 <20180918171000.GI16498@arm.com>
Message-ID: <139139a7-a769-006c-2cb7-491cc69379c8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2018-09-18 6:10 PM, Will Deacon wrote:
> Hi Robin,
> 
> Thanks for turning this around so quickly.

Cheers for a pretty rapid review too :)

> On Fri, Sep 14, 2018 at 03:30:18PM +0100, Robin Murphy wrote:
>> Since we'd like to get this polished up and merged and Leizhen has other
>> commitments, here's v7 of the previous series[1] wherein I address all
>> my own feedback :) This is a quick tweak of the v6 I sent yesterday
>> since I figured out slightly too late a much neater way of setting the
>> attribute at the appropriate time.
>>
>> The principal change is that I've inverted things slightly such that
>> it's now a generic domain attribute controlled by iommu-dma given the
>> necessary support from individual IOMMU drivers. That way we can easily
>> enable other drivers straight away, as I've done for SMMUv2 here (which
>> also allowed me to give it a quick test with MMU-401s on a Juno board).
>> Otherwise it's really just cosmetic cleanup and rebasing onto Will's
>> pending SMMU queue.
> 
> I've been through and had a look, leaving some small comments on the patches
> themselves. The only part I failed to figure out is how you tie the lifetime
> of the flush queue to the lifetime of the domain so that the timer callback
> can't fire after e.g. the DMA cookie has been freed. How does that work?

Er, to be honest I haven't looked or even considered it! Other than the 
parts I've massaged I kinda took the functionality of the previous 
series for granted. Let me cross-check the x86 code and figure it out.

Robin.
