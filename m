From: Steve.Capper@arm.com (Steve Capper)
Date: Thu, 8 Nov 2018 10:33:52 +0000
Subject: [PATCH V3 1/5] mm/hugetlb: Distinguish between migratability and
 movability
In-Reply-To: <1540299721-26484-2-git-send-email-anshuman.khandual@arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-2-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181108103340.ajeg566spidprzzk@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anshuman,

On Tue, Oct 23, 2018 at 06:31:57PM +0530, Anshuman Khandual wrote:
> During huge page allocation it's migratability is checked to determine if
> it should be placed under movable zones with GFP_HIGHUSER_MOVABLE. But the
> movability aspect of the huge page could depend on other factors than just
> migratability. Movability in itself is a distinct property which should not
> be tied with migratability alone.
> 
> This differentiates these two and implements an enhanced movability check
> which also considers huge page size to determine if it is feasible to be
> placed under a movable zone. At present it just checks for gigantic pages
> but going forward it can incorporate other enhanced checks.
> 
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

FWIW:
Reviewed-by: Steve Capper <steve.capper@arm.com>
