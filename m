From: tabbott@ksplice.com (Tim Abbott)
Date: Fri, 2 Oct 2009 16:32:41 -0400 (EDT)
Subject: [PATCH 2/2] arm: Clean up linker script using new linker	script
	macros.
In-Reply-To: <20091001125657.GA26910@n2100.arm.linux.org.uk>
References: <1254345935-15958-1-git-send-email-tabbott@ksplice.com>
	<1254345935-15958-3-git-send-email-tabbott@ksplice.com>
	<20090930213924.GB15732@merkur.ravnborg.org>
	<20091001125657.GA26910@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.1.10.0910021536510.19358@dr-wily.mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Oct 2009, Russell King - ARM Linux wrote:

> On Wed, Sep 30, 2009 at 11:39:25PM +0200, Sam Ravnborg wrote:
> > 
> > Where is _end in the new layout?
> > I think we lost it.
> 
> You're right - this will cause a build failure since _end is used in
> several core ARM files.  Tim?

It's supposed to be after BSS_SECTION.  I'll send you a new pair of 
patches with this fixed and Sam's acks added shortly.

> PS, please ensure that all patches are at the very least build tested,
> or say when they aren't.

These were build-tested originally; it seems I introduced this bug when 
rebasing the patch past the recent DISCARD changes, and failed to retest.  
Sorry about that (I think you are right that it was more generally a 
mistake to not clearly tag these patches as build-but-not-run tested in 
the first place.  I'll do that in the future).

My cross-compile environment is unavailable at present, so the new version 
will be completely untested as well.

	-Tim Abbott
