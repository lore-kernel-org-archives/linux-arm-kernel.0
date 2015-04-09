From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:11:49 +0100
Subject: [PATCH 3/7] ARM: cache-v7: consolidate initialisation of cache
 level index
In-Reply-To: <E1YdzF5-0008Cn-HQ@rmk-PC.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <E1YdzF5-0008Cn-HQ@rmk-PC.arm.linux.org.uk>
Message-ID: <20150409171149.GG23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 11:54:27AM +0100, Russell King wrote:
> Both v7_flush_cache_louis and v7_flush_dcache_all both begin the
> flush_levels loop with r10 initialised to zero.  In each case, this
> is done immediately prior to entering the loop.  Branch to this
> instruction in v7_flush_dcache_all from v7_flush_cache_louis and
> eliminate the unnecessary initialisation in v7_flush_cache_louis.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
