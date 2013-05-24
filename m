From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:18:42 +0100
Subject: [PATCH 05/11] mm: thp: Correct the HPAGE_PMD_ORDER check.
In-Reply-To: <1369328878-11706-6-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-6-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524111842.GI18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:07:52PM +0100, Steve Capper wrote:
> All Transparent Huge Pages are allocated by the buddy allocator.
> 
> A compile time check is in place that fails when the order of a
> transparent huge page is too large to be allocated by the buddy
> allocator. Unfortunately that compile time check passes when:
> HPAGE_PMD_ORDER == MAX_ORDER
> ( which is incorrect as the buddy allocator can only allocate
> memory of order strictly less than MAX_ORDER. )
> 
> This patch updates the compile time check to fail in the above
> case.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
