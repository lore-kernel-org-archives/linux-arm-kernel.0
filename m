From: david@gibson.dropbear.id.au (David Gibson)
Date: Tue, 30 Jul 2013 09:49:22 +1000
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130729231425.GA4439@obsidianresearch.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F39FD8.6080808@broadcom.com> <20130727183059.GD4813@netboy>
 <1441731.8CGUI1tUxh@flatron>
 <20130729180513.GB1884@obsidianresearch.com>
 <20130729222039.GE29970@voom.fritz.box>
 <20130729231425.GA4439@obsidianresearch.com>
Message-ID: <20130729234922.GI29970@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 05:14:25PM -0600, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2013 at 08:20:39AM +1000, David Gibson wrote:
> 
> > > Clearly general purpose systems (eg servers, workstations, etc) with
> > > *full featured firmware* fall into category b. Linux already basically
> > > has stable DT for those systems - but the firmware is expected to do
> > > lots of work and hide all the low level details from the
> > > kernel.  Basically, the DT should stick to approximately ePAR and
> > > everything else is hidden by the firmware.
> > 
> > No.  With the exception of the hypervisor/virtualization extensions,
> > ePAPR describes (for now) an entirely passive firmware interface.
> > That is, once the handover to the OS has happened, there is *no*
> > further firmware interaction.  It is not capable of hiding any details
> > from the OS, except those which can be done by one-time
> > initialization.
> 
> Well, one-time initialization details are actually exactly one of the
> areas I am thinking about. Some of the embedded SOCs have extensive
> one time initization code in the kernel that is highly SOC specific
> and on x86 it would live in the firmware.
> 
> But I see what you mean, ePAPR was the wrong reference, I didn't
> carefully check it. I ment the kind of DT use we've seen in SPARC,
> POWER servers, Apple stuff, etc - systems explicitly designed so that
> new hardware will boot old OSs.

Yeah, and at least for POWER servers and Apples, like every other
attempt at this, ever, it at best sorta-kinda worked.  It's not *as*
bad as the mess of broken BIOSes on x86 (mostly due to smaller
variety), but there's still plenty of broken crap in Apple workstation
and IBM server firmwares and device trees.

You see a clear line between "full featured" and "minimal" firmwares
where none exists.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/8890d07e/attachment.sig>
