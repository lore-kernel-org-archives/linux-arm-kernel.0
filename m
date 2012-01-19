From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 19 Jan 2012 08:36:38 +0100
Subject: [Linaro-mm-sig] [PATCH 04/11] mm: page_alloc: introduce
 alloc_contig_range()
In-Reply-To: <CA+K6fF6A1kPUW-2Mw5+W_QaTuLfU0_m0aMYRLOg98mFKwZOhtQ@mail.gmail.com>
References: <1325162352-24709-1-git-send-email-m.szyprowski@samsung.com>
 <1325162352-24709-5-git-send-email-m.szyprowski@samsung.com>
 <CA+K6fF6A1kPUW-2Mw5+W_QaTuLfU0_m0aMYRLOg98mFKwZOhtQ@mail.gmail.com>
Message-ID: <002901ccd67d$1465e560$3d31b020$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, January 17, 2012 10:54 PM sandeep patil wrote:

> I am running a CMA test where I keep allocating from a CMA region as long
> as the allocation fails due to lack of space.
> 
> However, I am seeing failures much before I expect them to happen.
> When the allocation fails, I see a warning coming from __alloc_contig_range(),
> because test_pages_isolated() returned "true".
> 
> The new retry code does try a new range and eventually succeeds.

(snipped)

> From the log it looks like the warning showed up because page->private
> is set to MIGRATE_CMA instead of MIGRATE_ISOLATED.

> I've also had a test case where it failed because (page_count() != 0)

This means that the page is temporarily used by someone else (like for example
io subsystem or a driver).

> Have you or anyone else seen this during the CMA testing?

Yes, we observed such issues and we are also working on fixing them. However 
we gave higher priority to get the basic CMA patches merged to mainline. Once
this happen the above issues can be fixed incrementally.

> Also, could this be because we are finding a page within (start, end)
> that actually belongs
> to a higher order Buddy block ?

No, such pages should be correctly handled.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
