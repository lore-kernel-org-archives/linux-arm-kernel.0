From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 21 Feb 2014 11:51:45 +0000
Subject: [RFC PATCH 2/2] arm: mm: Double logical invert for LPAE
 pte_write(), pte_dirty()
In-Reply-To: <20140221112812.GC21483@n2100.arm.linux.org.uk>
References: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
 <1392396913-13570-3-git-send-email-steve.capper@linaro.org>
 <20140221112812.GC21483@n2100.arm.linux.org.uk>
Message-ID: <20140221115145.GA7591@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 11:28:12AM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 14, 2014 at 04:55:13PM +0000, Steve Capper wrote:
> > On LPAE, L_PTE_WRITE and L_PTE_DIRTY are in the upper 32-bits.
> > Unfortunately, results from pte_write() and pte_dirty() are downcast
> > to 32-bits by core code:
> >   o gather_stats
> >   o huge_pte_dirty
> >   o huge_pte_write
> >   o make_migration_entry
> > 
> > This patch adds a double logical invert to pte_write() and pte_dirty()
> > for LPAE to ensure that the lower 32-bits are set if true.
> 
> We should ensure all those functions return something which is compatible
> with "int" correctly.  It didn't matter for non-LPAE as the PTEs fit in
> 32-bit, but with LPAE, that really needs fixing independently of your
> other patch.

Agreed, I'm getting that written/tested now for arm and arm64.

Cheers,
-- 
Steve

> 
> -- 
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
