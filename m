From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 16 Dec 2013 10:28:45 -0800
Subject: [PATCH] arm64: Correct virt_addr_valid
In-Reply-To: <20131213115757.GC22933@arm.com>
References: <1386724982-16997-1-git-send-email-lauraa@codeaurora.org>
 <1386724982-16997-2-git-send-email-lauraa@codeaurora.org>
 <20131211104429.GE26730@mudshark.cambridge.arm.com>
 <20131211110618.GG4360@n2100.arm.linux.org.uk>
 <20131211172635.GJ26730@mudshark.cambridge.arm.com>
 <20131211211333.GI4360@n2100.arm.linux.org.uk>
 <20131212175753.GG3382@arm.com>
 <20131212180249.GV4360@n2100.arm.linux.org.uk>
 <52AA3401.3000004@codeaurora.org> <20131213115757.GC22933@arm.com>
Message-ID: <52AF465D.8040000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2013 3:57 AM, Catalin Marinas wrote:
>
> OK, I re-read it now.
>
>> Yes, I believe the point was that if we call virt_addr_valid on a
>> not-direct-mapped address it should return false. We still need the
>> range check on arm64 systems as well to ensure this.
>
> On arm64 we don't have highmem, so all RAM would be directly mapped (and
> linear). Is there a case on a 64-bit architecture where pfn_valid() is
> true but the memory not mapped? We don't unmap any memory which is
> pfn_valid().
>

We don't have highmem but we still have a vmalloc region. Calling 
virt_to_page on a vmalloc address will not give a valid page so 
virt_addr_valid should return false on anything in the vmalloc region.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
