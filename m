From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Oct 2012 18:44:28 +0100
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
Message-ID: <20121008174428.GB3204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 12:29:12PM +0100, Simon Baatz wrote:
> Commit f8b63c1 made flush_kernel_dcache_page() a no-op assuming that
> the pages it needs to handle are kernel mapped only.  However, for
> example when doing direct I/O, pages with user space mappings may
> occur.
> 
> Thus, do lazy flushing like in flush_dcache_page() if there are no user
> space mappings.  Otherwise, flush the kernel cache lines directly.

Do you need to fix the VIPT non-aliasing case as well? Does
flush_kernel_dcache_page() need to handle I-cache?

-- 
Catalin
