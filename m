From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Mar 2013 11:05:18 +0000
Subject: [PATCH 1/3] ARM: cacheflush: don't round address range up to
 nearest page
In-Reply-To: <1364235486-17738-2-git-send-email-will.deacon@arm.com>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
 <1364235486-17738-2-git-send-email-will.deacon@arm.com>
Message-ID: <20130327110518.GF801@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:18:04PM +0000, Will Deacon wrote:
> The flush_cache_user_range macro takes a pair of addresses describing
> the start and end of the virtual address range to flush. Due to an
> accidental oversight when flush_cache_range_user was introduced, the
> address range was rounded up so that the start and end addresses were
> page-aligned.

I don't think it was an accidental oversight but it was actually
covering other issue where writing an instruction caused a full page
CoW. We've fixed this issue since, so the patch is ok.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
