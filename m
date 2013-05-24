From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:01:22 +0100
Subject: [PATCH v2 2/4] ARM: mm: Add support for flushing HugeTLB pages.
In-Reply-To: <1369323080-9673-3-git-send-email-steve.capper@linaro.org>
References: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
 <1369323080-9673-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524110122.GB18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 04:31:18PM +0100, Steve Capper wrote:
> On ARM we use the __flush_dcache_page function to flush the dcache
> of pages when needed; usually when the PG_dcache_clean bit is unset
> and we are setting a PTE.
> 
> A HugeTLB page is represented as a compound page consisting of an
> array of pages. Thus to flush the dcache of a HugeTLB page, one must
> flush more than a single page.
> 
> This patch modifies __flush_dcache_page such that all constituent
> pages of a HugeTLB page are flushed.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
