From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Dec 2015 11:51:46 +0000
Subject: [PATCH v4 0/2] arm64: change PoC D-cache flush to PoU
In-Reply-To: <1450345112-3657-1-git-send-email-ashoks@broadcom.com>
References: <1450345112-3657-1-git-send-email-ashoks@broadcom.com>
Message-ID: <20151217115146.GD11456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 01:38:30AM -0800, Ashok Kumar wrote:
> For keeping I and D coherent, dcache flush till PoU(Point of Unification)
> should be sufficient instead of doing till PoC(Point of coherence).
> In SoC with more levels of cache, there could be a performance hit in doing
> flush till PoC as __flush_dcache_area does both flush and invalidate.
> Introduced new API __clean_dcache_area_pou which does only clean till PoU.
> 
> Also deferred dcache flush in __cpu_copy_user_page to __sync_icache_dcache.

Thanks, Ashok. I've queued this locally and will push out once I've
given it a good kicking.

Will
