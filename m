From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 May 2010 22:58:25 +0100
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100513211951.GH3428@atomide.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100505150209.GC2606@n2100.arm.linux.org.uk>
	<20100513174023.GB13001@n2100.arm.linux.org.uk>
	<20100513211951.GH3428@atomide.com>
Message-ID: <20100513215825.GC13001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 02:19:51PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 10:35]:
> > And here's a patch which converts the OMAP FB code to use lmb_reserve
> > instead of poking about with bootmem stuff.  Untested, so I'd like to
> > hear back whether it works.
> 
> Did a quick test with the following patches picked from your lmb
> branch on top of omap for-next branch:
> 
> ARM: Remove useless linux/bootmem.h includes
> ARM: Ensure meminfo is sorted prior to sanity_check_meminfo
> ARM: initial LMB trial
> ARM: Move platform LMB memory reservations out of generic code
> 
> and then this patch.
> 
> It does not boot.. It seems to be related to the patch
> "ARM: initial LMB trial". If I only apply the first two patches
> above the system boots.

Hmm, I'm sure it worked for me when I tested it out.  Could you try
booting with lmb=debug please?
