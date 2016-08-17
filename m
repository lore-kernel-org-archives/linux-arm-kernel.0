From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 17 Aug 2016 07:12:06 -0400
Subject: [PATCH] arm64: Expose TASK_SIZE to userspace via auxv
In-Reply-To: <20160817103006.GB20762@e104818-lin.cambridge.arm.com>
References: <20160816183231.21179-1-cov@codeaurora.org>
 <20160817103006.GB20762@e104818-lin.cambridge.arm.com>
Message-ID: <CED1E802-65C5-48B9-8165-46684BE81164@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On August 17, 2016 6:30:06 AM EDT, Catalin Marinas <catalin.marinas@arm.com> wrote:
>On Tue, Aug 16, 2016 at 02:32:29PM -0400, Christopher Covington wrote:
>> Some userspace applications need to know the maximum virtual address
>they can
>> use (TASK_SIZE).
>
>Just curious, what are the cases needing TASK_SIZE in user space?

Checkpoint/Restore In Userspace and the Mozilla Javascript Engine https://bugzilla.mozilla.org/show_bug.cgi?id=1143022 are the specific cases I've run into. I've heard LuaJIT might have a similar situation. In general I think making allocations from the top down is a shortcut for finding a large unused region of memory.

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

Sent from my Snapdragon powered Android device with K-9 Mail. Please excuse my brevity.
