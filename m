From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 03 Jun 2014 17:30:18 -0700
Subject: [PATCHv2] arm64: Add atomic pool for non-coherent and CMA
 allocaitons.
In-Reply-To: <20140603132842.GI23149@arm.com>
References: <1401739432-5358-1-git-send-email-lauraa@codeaurora.org>
 <20140603132842.GI23149@arm.com>
Message-ID: <538E689A.3050109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/3/2014 6:28 AM, Will Deacon wrote:
> Hi Laura,
> 
> On Mon, Jun 02, 2014 at 09:03:52PM +0100, Laura Abbott wrote:
>> Neither CMA nor noncoherent allocations support atomic allocations.
>> Add a dedicated atomic pool to support this.
>>
>> Change-Id: I46c8fdffe5e0687403d42b37643137c8cf344259
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>
>> v2: Various bug fixes pointed out by David and Ritesh (CMA dependency, swapping
>> coherent, noncoherent). I'm still not sure how to address the devicetree
>> suggestion by Will [1][2]. I added the devicetree mailing list this time around
>> to get more input on this.
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249180.html
>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249528.html
> 
> Perhaps that can be done later then, since from what you're saying, we need
> the command-line option either way? Have you looked at how this fits in with
> the iommu-helper work from Ritesh? We could put the parameter parsing in
> there too.
> 

This doesn't seem to overlap with Ritesh's work. The atomic mapping is still
handled in the arm specific code so I assume it would be handled in the arm64
specific code as well. Another question might be is if it would be useful to
make the atomic code common somehow between arm and arm64.

> Will
> 

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
