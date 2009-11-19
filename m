From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 08:57:35 +0000
Subject: cache aliasing in dup_mmap
In-Reply-To: <20091116222016.GF3568@n2100.arm.linux.org.uk>
References: <20090308143607.GA27349@n2100.arm.linux.org.uk>
	<e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
	<e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
	<20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091005144623.GA20633@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
	<20091116163028.GA3568@n2100.arm.linux.org.uk>
	<e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
	<20091116222016.GF3568@n2100.arm.linux.org.uk>
Message-ID: <20091119085735.GA14178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 10:20:16PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 16, 2009 at 12:23:36PM -0500, Steven Walter wrote:
> > Yes, SIGSEGV after 88 boots, with a crash that we previously
> > identified as caused by this cache corruption issue.  Attached are the
> > patches I used, as manually backported to 2.6.18.5.  Stock 2.6.18.5
> > would reliably crash in under 1000 reboots, whereas  with my ad-hoc
> > fix (also attached) we were able to run 8000 reboots before we ended
> > the test.
> 
> I can see no reason for the difference between the two.  The backport
> looks fine.
> 
> The only difference I can see is:
> 
> - version which works
> 
> > diff --git a/src/mm/memory.c b/src/mm/memory.c
> > index 0b7a668..d0bc8c1 100644
> 
> - version which doesn't
> 
> > diff --git a/src/mm/memory.c b/src/mm/memory.c
> > index f508c60..69d8d32 100644
> 
> That first index number gives the sha1 hash of the git object storing
> this file.  Since they're different, these two patches weren't applied
> to the same file.
> 
> Could there be other changes in your tree which could be affecting the
> behaviour in this area?

I'm afraid that I have nothing further to suggest, and so I'm shelving
the patches.  That means this problem will remain unresolved in future
kernels.
