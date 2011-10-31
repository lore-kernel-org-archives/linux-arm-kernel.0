From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 14:39:04 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <CAH+eYFDM_spE8jg4K5awBPZvPyEmdhSnQ9Zt=v2U4PmFQeRLOw@mail.gmail.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
	<CAH+eYFDM_spE8jg4K5awBPZvPyEmdhSnQ9Zt=v2U4PmFQeRLOw@mail.gmail.com>
Message-ID: <20111031143904.GM19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 08:03:26PM +0530, Rabin Vincent wrote:
> On Mon, Oct 31, 2011 at 19:43, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > $ spatch -sp_file arch_reset-1.cocci arch/arm/*/include/*/system.h > arch_reset-1.diff
> >
> > The diff it created contains:
> >
> > --- arch/arm/mach-ep93xx/include/mach/system.h ?2011-03-04 19:52:46.419272878 +0000
> > +++ /tmp/cocci-output-380-f841cc-system.h ? ? ? 2011-10-31 13:54:52.066705107 +0000
> > ...
> > --- arch/arm/mach-iop32x/include/mach/system.h ?2011-03-04 19:52:46.445272534 +0000
> > +++ /tmp/cocci-output-380-c0e3f4-system.h ? ? ? 2011-10-31 13:54:52.072705051 +0000
> > ...
> > --- arch/arm/mach-ixp2000/include/mach/system.h 2011-03-04 19:52:46.449272482 +0000
> > +++ /tmp/cocci-output-380-467f17-system.h ? ? ? 2011-10-31 13:54:52.079704984 +0000
> > ...
> >
> > which in total deletes 6 lines. ?However, the patch is rejected by
> > git apply and gnu patch as it stands - it needs the filenames to be
> > edited to something more reasonable. ?So that also takes six edits.
> 
> The above patch will apply with gnu patch if you use -p0.

$ patch -p0 -i arch_reset-1.diff --dry-run
patch: **** rejecting absolute target file name: /tmp/cocci-output-380-f841cc-system.h
