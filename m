From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Mar 2017 19:55:07 +0100
Subject: [PATCHv2,6/7] mm: convert generic code to 5-level paging
In-Reply-To: <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
References: <20170309142408.2868-7-kirill.shutemov@linux.intel.com>
 <2565467.lozgIVsiVn@diego>
 <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
Message-ID: <15847703.KEZMYLnFVy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. M?rz 2017, 20:06:25 CET schrieb Kirill A. Shutemov:
> On Tue, Mar 14, 2017 at 05:14:22PM +0100, Heiko St?bner wrote:
> > [added arm64 maintainers and arm list to recipients]
> > 
> > Hi,
> > 
> > Am Donnerstag, 9. M?rz 2017, 17:24:07 CET schrieb Kirill A. Shutemov:
> > > Convert all non-architecture-specific code to 5-level paging.
> > > 
> > > It's mostly mechanical adding handling one more page table level in
> > > places where we deal with pud_t.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > This breaks (at least) arm64 Rockchip platforms it seems.
> > 
> > 4.11-rc1 worked just fine, while 4.11-rc2 kills the systems and I've
> > bisected it down to this one commit.
> 
> Have you tried current Linus' tree? There is important fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> d=ce70df089143c49385b4f32f39d41fb50fbf6a7c

thanks for the pointer ... my arm64 board seem to boot now again.

While I did look for responses to the original series [0] + [1], where there 
weren't any, I didn't think to just look into Linus' tree if there was some 
fixup already. 

So sorry for the noise and all seems well now
Heiko


[0] https://lkml.org/lkml/2017/3/9/442
[1] https://patchwork.kernel.org/patch/9613445/
