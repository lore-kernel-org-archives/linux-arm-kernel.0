From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Dec 2013 15:54:04 +0000
Subject: [PATCH V2] arm: mm: fix dcache flush logic for compound high pages
In-Reply-To: <1387206223-1670-1-git-send-email-steve.capper@linaro.org>
References: <1387206223-1670-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20131216155403.GC20193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 03:03:43PM +0000, Steve Capper wrote:
> When given a compound high page, __flush_dcache_page will only flush
> the first page of the compound page repeatedly rather than the entire
> set of constituent pages.
> 
> This patch corrects the logic such that all constituent pages are now
> flushed.

Since this probably wants to go to -stable, it's worth mentioning the commit
which introduced it in the commit text.

> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> V2: style change use page + i rather than separate struct *cpage
> ---

  Acked-by: Will Deacon <will.deacon@arm.com>

Cheers Steve.

Will
