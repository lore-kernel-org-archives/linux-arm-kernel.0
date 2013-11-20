From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Nov 2013 13:56:18 +0000
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131120131004.ACA1BC4079D@trevor.secretlab.ca>
References: <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <20131119142336.GA28859@titan.lakedaemon.net>
 <20131119150212.GM16735@n2100.arm.linux.org.uk>
 <20131119152047.GB28859@titan.lakedaemon.net>
 <20131119152146.GN16735@n2100.arm.linux.org.uk>
 <20131119192246.GP16735@n2100.arm.linux.org.uk>
 <20131120131004.ACA1BC4079D@trevor.secretlab.ca>
Message-ID: <20131120135617.GS16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 01:10:04PM +0000, Grant Likely wrote:
> On Tue, 19 Nov 2013 19:22:46 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Tue, Nov 19, 2013 at 03:21:46PM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Nov 19, 2013 at 10:20:47AM -0500, Jason Cooper wrote:
> > > > By "That" are you referring to extending the standard for compatible
> > > > strings to the board level, or forcing consistent naming on the dts
> > > > files?
> > > 
> > > A consistent file naming on both the dtb and dts files.
> > 
> > It's time to knock the idea of naming the DT blobs after the compatible
> > string on its head as well.  That's really not going to work.  Just
> > leave the filenames as is, and move the problem into userspace to solve.
> > 
> [...]
> > 
> > Just use the filenames we already have in the kernel tree.  Let userspace
> > parse the DT blobs for the compatible strings - it can then provide the
> > user with the choice of all and _also_ show that certain of DT blobs
> > may be compatible with a range of boards as well.
> 
> Yes, the consistent filename format is a non-problem. The files that
> exist already have names. Nothing else is going to use them. Done.

Grant, you have the wrong end of the stick.  This discussion is about
what happens when files from

	$(objtree)/arch/arm/boot/dts

get installed into

	/lib/modules/$(kernelversion)/...

and their renaming from the filenames we already have in arch/arm/boot/dts
to a filename generated from the compatible string.
