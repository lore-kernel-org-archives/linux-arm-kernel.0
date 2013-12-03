From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 02 Dec 2013 20:59:43 -0800
Subject: [RFC PATCH 3/4] mm/vmalloc.c: Allow lowmem to be tracked in
 vmalloc
In-Reply-To: <20131126144541.6b16979b77f927f6d945ab60@linux-foundation.org>
References: <1384212412-21236-1-git-send-email-lauraa@codeaurora.org>	<1384212412-21236-4-git-send-email-lauraa@codeaurora.org>	<52850C37.1080506@sr71.net>	<5285A896.3030204@codeaurora.org>
 <20131126144541.6b16979b77f927f6d945ab60@linux-foundation.org>
Message-ID: <529D653F.3090401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 2:45 PM, Andrew Morton wrote:
> So yes, it would be prudent to be worried about is_vmalloc_addr()
> performance at the outset.
>
> Couldn't is_vmalloc_addr() just be done with a plain old bitmap?  It
> would consume 128kbytes to manage a 4G address space, and 1/8th of a meg
> isn't much.
>

Yes, I came to the same conclusion after realizing I needed something 
similar to fix up proc/kcore.c . I plan to go with the bitmap for the 
next patch version.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
