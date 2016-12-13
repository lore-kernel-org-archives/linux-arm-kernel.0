From: alex.popov@linux.com (Alexander Popov)
Date: Wed, 14 Dec 2016 01:07:51 +0300
Subject: [PATCH 1/2] arm64: setup: introduce kaslr_offset()
In-Reply-To: <20161212112914.GC21248@arm.com>
References: <1481417456-28826-1-git-send-email-alex.popov@linux.com>
 <1481417456-28826-2-git-send-email-alex.popov@linux.com>
 <20161212112914.GC21248@arm.com>
Message-ID: <183ee3f1-5e2e-4512-6300-cc804e2baa4e@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.12.2016 14:29, Will Deacon wrote:
> On Sun, Dec 11, 2016 at 03:50:55AM +0300, Alexander Popov wrote:
>> Introduce kaslr_offset() similarly to x86_64 for fixing kcov.
>>
>> Signed-off-by: Alexander Popov <alex.popov@linux.com>
>> ---
>>  arch/arm64/include/asm/setup.h      | 19 +++++++++++++++++++
>>  arch/arm64/include/uapi/asm/setup.h |  4 ++--
>>  arch/arm64/kernel/setup.c           |  8 ++++----
>>  3 files changed, 25 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/setup.h
> 
> You could probably just stick this in asm/memory.h, since that's where
> kimage_vaddr is declared and it would save adding a new header file.

Thanks, Will. I'll do that.

--
Alexander
