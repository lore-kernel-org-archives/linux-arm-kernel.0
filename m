From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 6 Dec 2011 11:52:36 -0800
Subject: [PATCH] highmem: Fix ARM build break due to __kmap_atomic rename
In-Reply-To: <alpine.LFD.2.02.1112061440050.2357@xanadu.home>
References: <1323197426-10815-1-git-send-email-swarren@nvidia.com>
 <alpine.LFD.2.02.1112061440050.2357@xanadu.home>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B774A6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote at Tuesday, December 06, 2011 12:42 PM:
> On Tue, 6 Dec 2011, Stephen Warren wrote:
> > Git commit 37bfbb9 "highmem: kill all __kmap_atomic()" renamed
> > __kmap_atomic to kmap_atomic. However, arch/arm/include/asm/highmem.h
> > wasn't updated for that change. This change does so, and fixes the
> > ARM build break.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > This shows up in next-20111206 at least.
> 
> Commit 37bfbb9 doesn't show up in anything which is stable yet.  Would
> be best to ask the original author to fix his branch.

Yes, I assumed that Cong would squash this into his/her tree that's in
linux-next.

-- 
nvpublic
