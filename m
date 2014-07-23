From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 23 Jul 2014 22:49:09 +0900
Subject: [PATCH 13/11] arm64: Add support for 48-bit VA space with 64KB
 page configuration
In-Reply-To: <20140722153738.GJ2219@arm.com>
References: <ADA477FA-165D-4679-A38F-C82C901BEE4D@gmail.com>
 <AABDB416-D194-4825-8113-4748C10BC339@gmail.com>
 <2C360BFC-E4CF-448D-9110-4197DCAEAD4F@gmail.com>
 <20140722153738.GJ2219@arm.com>
Message-ID: <619F8412-0992-4C87-AF55-83F70E605F7A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 23, 2014, at 12:37 AM, Catalin Marinas wrote:
> On Tue, Jul 22, 2014 at 04:13:27PM +0100, Jungseok Lee wrote:
>> On Jul 22, 2014, at 00:09 +900 Catalin Marinas wrote:
>>> This patch allows support for 3 levels of page tables with 64KB page 
>>> configuration allowing 48-bit VA space. The pgd is no longer a full 
>>> PAGE_SIZE (PTRS_PER_PGD is 64) and (swapper|idmap)_pg_dir are not fully 
>>> populated (pgd_alloc falls back to kzalloc). 
>>> 
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com> 
>>> --- 
>> 
>> One more step :)
> 
> The last before the upcoming merging window. I also updated the
> pgtable-4levels branch with the latest.

I've tested the latest potable-4levels branch and 64KB + 3 Levels
works fine on model.

Tested-by: Jungseok Lee <jungseoklee85@gmail.com>

I hope that I'm not too late since this series is already in for-next/core
branch of arm64/linux.git repo. 

- Jungseok Lee
