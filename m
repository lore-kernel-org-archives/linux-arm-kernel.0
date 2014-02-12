From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Feb 2014 10:14:23 +0000
Subject: [PATCH 2/3] arm64: mm: Route pmd thp functions through pte
 equivalents
In-Reply-To: <1391696171-8922-3-git-send-email-steve.capper@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
 <1391696171-8922-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20140212101423.GC29702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 02:16:10PM +0000, Steve Capper wrote:
> Rather than have separate hugetlb and transparent huge page pmd
> manipulation functions, re-wire our thp functions to simply call the
> pte equivalents.

That's one thing I don't like about hugetlb, casting pmds to ptes. Do we
actually save much in terms of code clean-up by doing this?

-- 
Catalin
