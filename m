From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Oct 2012 12:36:07 +0100
Subject: [PATCH V2 1/2] ARM: remove unnecessary flush of anon pages in
 flush_dcache_page()
In-Reply-To: <1349609352-6408-2-git-send-email-gmbnomis@gmail.com>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-2-git-send-email-gmbnomis@gmail.com>
Message-ID: <20121008113606.GB31458@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 12:29:11PM +0100, Simon Baatz wrote:
> On non-aliasing VIPT D-caches, there is no need to flush the kernel
> mapping of anon pages in flush_dcache_page() directly.  If the page is
> mapped as executable later, the necessary D/I-cache flush will be done
> in __sync_icache_dcache().
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
