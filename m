From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 19 Jan 2012 13:09:11 -0500 (EST)
Subject: [PATCH v6 9/9] ARM: vexpress: Add Device Tree for V2P-CA15 core
 tile (TC1 variant)
In-Reply-To: <CACxGe6tWCd83qcfAv8=x3mdGNHR6xEnS=Gyq=bnWxRw22M4QXA@mail.gmail.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-10-git-send-email-pawel.moll@arm.com>
 <4F0C495C.4000103@citrix.com>
 <1326979652.32197.66.camel@hornet.cambridge.arm.com>
 <4F181BD9.20401@gmail.com>
 <1326980594.32197.67.camel@hornet.cambridge.arm.com>
 <4F182248.7070209@gmail.com>
 <1326984672.32197.68.camel@hornet.cambridge.arm.com>
 <4F184C48.2050505@citrix.com>
 <1326994035.13748.7.camel@hornet.cambridge.arm.com>
 <20120119175053.GE10404@n2100.arm.linux.org.uk>
 <CACxGe6tWCd83qcfAv8=x3mdGNHR6xEnS=Gyq=bnWxRw22M4QXA@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1201191305180.19587@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jan 2012, Grant Likely wrote:

> On Thu, Jan 19, 2012 at 10:50 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jan 19, 2012 at 05:27:15PM +0000, Pawel Moll wrote:
> >> On Thu, 2012-01-19 at 17:00 +0000, David Vrabel wrote:
> >> > The problem wasn't with including skeleton.dtsi.
> >>
> >> Including as it is creates two device_type="memory" nodes, one with
> >> regs=<0 0>, which is definitely wrong.
> >>
> >> > With
> >> > CONFIG_ARM_ATAG_DTB_COMPAT the zImage decompressor modifies the appended
> >> > DTB using information from the ATAGs (see atags_to_fdt()).
> >> >
> >> > If there's an ATAG giving the amount of RAM the DTB's "memory" node is
> >> > replaced with a new one. ?Since the vexpress DTBs don't have a "memory"
> >> > node it's added and the DTB ends up with two nodes describing memory.
> >>
> >> The "memory at address" node name is in my opinion perfectly legal - p. 3.4
> >> of the DT spec says "The name component of the node name (see 2.2.1)
> >> shall be memory.". So the decompressor code may be wrong in looking for
> >> adress-less "memory" node...
> >
> > I don't think you can expect such early code to properly parse a DT tree
> > with a variability in how memory stuff is declared into that DT tree.
> >
> > What if you have two memory nodes specified in the DT file, and the
> > ATAG data contains one?
> 
> Yes, just because it is technically legal doesn't make it okay.  The
> pragmatic approach here is that the skeleton.dtsi file calls the node
> "memory", so this .dts file must do the same.
> 
> > The more I look at this, the more I'm convinced that Grant's idea that
> > DT should entirely override ATAGs all the way to the kernel proper was
> > the wrong solution - at least in the kernel, if we had both available,
> > we could make a choice there, and have the full DT library to be able
> > to manipulate the DT blob.
> 
> Hey!  I was originally lobbying for the dt pointer carried by an ATAG.
>  Nico conviced me otherwise.  :-)

Hey!  I was originally lobbying for people to have a fully DT aware 
bootloader if they wanted to play with DT, otherwise there is no 
incentive for updated bootloaders.  But someone else convinced me 
otherwise.  :-)

Mixed bags always have loose ends.


Nicolas
