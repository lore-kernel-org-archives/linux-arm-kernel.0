From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 14 Mar 2017 20:06:25 +0300
Subject: [PATCHv2,6/7] mm: convert generic code to 5-level paging
In-Reply-To: <2565467.lozgIVsiVn@diego>
References: <20170309142408.2868-7-kirill.shutemov@linux.intel.com>
 <2565467.lozgIVsiVn@diego>
Message-ID: <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 05:14:22PM +0100, Heiko St?bner wrote:
> [added arm64 maintainers and arm list to recipients]
> 
> Hi,
> 
> Am Donnerstag, 9. M?rz 2017, 17:24:07 CET schrieb Kirill A. Shutemov:
> > Convert all non-architecture-specific code to 5-level paging.
> > 
> > It's mostly mechanical adding handling one more page table level in
> > places where we deal with pud_t.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> This breaks (at least) arm64 Rockchip platforms it seems.
> 
> 4.11-rc1 worked just fine, while 4.11-rc2 kills the systems and I've bisected 
> it down to this one commit.

Have you tried current Linus' tree? There is important fix:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce70df089143c49385b4f32f39d41fb50fbf6a7c

-- 
 Kirill A. Shutemov
