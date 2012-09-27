From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Sep 2012 13:23:28 +0100
Subject: [PATCH 2/2] ARM: remove unnecessary flush of anon pages in
 flush(_kernel)_dcache_page()
In-Reply-To: <1348695659-27603-3-git-send-email-gmbnomis@gmail.com>
References: <1348695659-27603-1-git-send-email-gmbnomis@gmail.com>
 <1348695659-27603-3-git-send-email-gmbnomis@gmail.com>
Message-ID: <20120927122327.GA26188@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 10:40:59PM +0100, Simon Baatz wrote:
> On non-aliasing VIPT D-caches, there is no need to flush the kernel
> mapping of anon pages in flush_kernel_dcache_page() and
> flush_dcache_page() directly.  If the page is mapped as executable
> later, the necessary D/I-cache flush will be done in
> __sync_icache_dcache().
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>

I would suggest you make this patch the first one rather than
introducing __flush_kernel_dcache_page() and subsequently replacing its
code.

-- 
Catalin
