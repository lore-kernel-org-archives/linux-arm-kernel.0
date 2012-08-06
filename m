From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Aug 2012 20:40:16 +0100
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
 <20120806190856.GA1120@n2100.arm.linux.org.uk>
 <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
Message-ID: <20120806194016.GB1120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 02:30:48PM -0500, Matt Sealey wrote:
> On Mon, Aug 6, 2012 at 2:08 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Aug 06, 2012 at 01:40:26PM -0500, Matt Sealey wrote:
> >> Maybe we could implement a shiny new zImage magic value, I'm not sure
> >> if 0x016f2818 might have some sentimental value, but there's nothing
> >> to say that 0x016f2819 wouldn't also be valid and indicate that it's
> >> an ARM zImage with a Thumb2 entrypoint?
> >
> > No.  That magic value is a bloody pain in the backside from my point
> > of view.  I've had soo many problems with it with boot loaders its
> > untrue.
> 
> [snip]
> 
> > Instead, lets not continue this broken idea.  Instead, let's be able
> > to _tell_ the boot loader what we want it to do, rather than have it
> > magically decipher what _it_ thinks might be a good idea to do.
> 
> Okay, so how about we just append an ELF header to the front of the
> image so the entry point, and the architecture, instruction
> set, ABI etc. is well defined in an industry standard manner?
> 
> e_entry would then have the LSB set which indicates the entry is
> Thumb.. or not :)

No.  Take a moment to think about what you're saying.  Are you really
saying no to the single kernel image project?

Because anything that involves wrapping the kernel up in an "industry
standard manner" like an ELF header places fixed addresses (like the
entry point) into the kernel, and then we're back to the same problem
that every SoC vendor places their RAM at different places in the
system memory map.

No.  Can't do that.  Sorry.
