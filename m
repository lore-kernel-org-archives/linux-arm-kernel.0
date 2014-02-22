From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 22 Feb 2014 23:30:19 +0100
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140222101655.GE21483@n2100.arm.linux.org.uk>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
 <20140222101655.GE21483@n2100.arm.linux.org.uk>
Message-ID: <20140222223019.GB20490@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2014-02-22 10:16:55, Russell King - ARM Linux wrote:
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

Actually, x86-64 is able to resume from different kernel these days,
and some day you may want to do it on arm, too. But it is definitely
not needed for inital merge.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
