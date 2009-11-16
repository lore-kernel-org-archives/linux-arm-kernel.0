From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2009 17:28:56 +0000
Subject: cache aliasing in dup_mmap
In-Reply-To: <e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
References: <20090308121029.GA21277@n2100.arm.linux.org.uk>
	<20090308143607.GA27349@n2100.arm.linux.org.uk>
	<e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
	<e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
	<20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091005144623.GA20633@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
	<20091116163028.GA3568@n2100.arm.linux.org.uk>
	<e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
Message-ID: <20091116172856.GE3568@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 12:23:36PM -0500, Steven Walter wrote:
> On Mon, Nov 16, 2009 at 11:30 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> I apologize for the late reply. ?I have a build with your patches
> >> running in a reboot loop (the easiest way for us to reproduce the
> >> crash). ?I should have a good indication of whether the patches fix
> >> the issue by Monday.
> >
> > Any results?
> 
> Yes, SIGSEGV after 88 boots, with a crash that we previously
> identified as caused by this cache corruption issue.  Attached are the
> patches I used, as manually backported to 2.6.18.5.  Stock 2.6.18.5
> would reliably crash in under 1000 reboots, whereas  with my ad-hoc
> fix (also attached) we were able to run 8000 reboots before we ended
> the test.

What is copypage-swl.S ?
