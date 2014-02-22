From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 22 Feb 2014 12:13:15 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140222101655.GE21483@n2100.arm.linux.org.uk>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
 <20140222101655.GE21483@n2100.arm.linux.org.uk>
Message-ID: <20140222121315.GB9012@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 10:16:55AM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 20, 2014 at 04:27:55PM +0000, Lorenzo Pieralisi wrote:
> > I still do not understand why switching to idmap, which is a clone of
> > init_mm + 1:1 kernel mappings is required here. Why idmap ?
> > 
> > And while at it, can't the idmap be overwritten _while_ copying back the
> > resume kernel ? Is it safe to use idmap page tables while copying ?
> > 
> > I had a look at x86 and there idmap page tables used to resume are created
> > on the fly using safe pages, on ARM idmap is created at boot.
> 
> That's fine.
> 
> Remember, you're required to boot exactly the same kernel image when
> resuming as the kernel which created the suspend image.  Unless you
> have random allocations going on, you should get the same layout for
> the idmap stuff at each boot.

Thanks Russell, now that's clear. We do need a copy of page tables
that are not tampered with while copying, and idmap works well for
that.

Lorenzo
