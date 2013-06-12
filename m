From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 12 Jun 2013 20:59:09 +0200
Subject: [PATCH V5] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130610102307.GC1947@darko.cambridge.arm.com>
References: <1370462344-7128-1-git-send-email-gmbnomis@gmail.com>
 <20130610102307.GC1947@darko.cambridge.arm.com>
Message-ID: <20130612185909.GA6945@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Mon, Jun 10, 2013 at 11:23:07AM +0100, Catalin Marinas wrote:
> On Wed, Jun 05, 2013 at 08:59:04PM +0100, Simon Baatz wrote:
> > Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> > it needs to handle are kernel mapped only.  However, for example when doing
> > direct I/O, pages with user space mappings may occur.
> > 
> > Thus, continue to do lazy flushing if there are no user space mappings.
> > Otherwise, flush the kernel cache lines directly.
> > 
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > Cc: <stable@vger.kernel.org> # 3.2+
> > CC: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for the review. This is submitted now as patch #7755/1 in
Russell's patch system.

- Simon
