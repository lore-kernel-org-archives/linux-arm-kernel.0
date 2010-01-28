From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 28 Jan 2010 14:55:30 +0000
Subject: [PATCH] ARM: Always generate the IT instruction when compilingfor
	Thumb-2
In-Reply-To: <1264683904.7064.57.camel@pc1117.cambridge.arm.com>
References: <20100127220223.GC29665@n2100.arm.linux.org.uk>
	<1264683904.7064.57.camel@pc1117.cambridge.arm.com>
Message-ID: <20100128145530.GC24679@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Wed, 2010-01-27 at 22:02 +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 26, 2010 at 10:14:24AM +0000, Catalin Marinas wrote:
> > > Current behaviour is to generate the IT instruction only for Thumb-2
> > > code. However, the kernel helpers in entry-armv.S are compiled to ARM in
> > > a unified syntax file (if THUMB2_KERNEL). Recent compilers warn about
> > > missing IT instruction in unified assembly syntax files. The patch
> > > changes the "-mimplicit-it" gas option to "always".
> > 
> > Any downsides to this change?  Any assemblers not accepting "always"
> > instead of "thumb" ?
> 
> When the -mimplicit-it was merged into mainline gas, it supported all of
> thumb, arm, always and never. We still have the old -mauto-it but that's
> I think only valid for the CodeSourcery toolchains.

I notice there's a few "it" dotted around the kernel code now.  In
fact, that's how I learned about it - because I thought "that can't be
right when targetting ARM", and did some reading to learn otherwise.

With -mimplicit-it=always, they should not be needed.  So they can be
removed from the kernel source?

Or, if it's policy to put "it" in all the places needed, wouldn't
-mimplicit-it=arm (the gas default) be a better choice, to make sure
they are in all the places needed?

-- Jamie
