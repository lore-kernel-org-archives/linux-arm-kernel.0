From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 29 Jul 2013 17:14:25 -0600
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130729222039.GE29970@voom.fritz.box>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F39FD8.6080808@broadcom.com> <20130727183059.GD4813@netboy>
 <1441731.8CGUI1tUxh@flatron>
 <20130729180513.GB1884@obsidianresearch.com>
 <20130729222039.GE29970@voom.fritz.box>
Message-ID: <20130729231425.GA4439@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 08:20:39AM +1000, David Gibson wrote:

> > Clearly general purpose systems (eg servers, workstations, etc) with
> > *full featured firmware* fall into category b. Linux already basically
> > has stable DT for those systems - but the firmware is expected to do
> > lots of work and hide all the low level details from the
> > kernel.  Basically, the DT should stick to approximately ePAR and
> > everything else is hidden by the firmware.
> 
> No.  With the exception of the hypervisor/virtualization extensions,
> ePAPR describes (for now) an entirely passive firmware interface.
> That is, once the handover to the OS has happened, there is *no*
> further firmware interaction.  It is not capable of hiding any details
> from the OS, except those which can be done by one-time
> initialization.

Well, one-time initialization details are actually exactly one of the
areas I am thinking about. Some of the embedded SOCs have extensive
one time initization code in the kernel that is highly SOC specific
and on x86 it would live in the firmware.

But I see what you mean, ePAPR was the wrong reference, I didn't
carefully check it. I ment the kind of DT use we've seen in SPARC,
POWER servers, Apple stuff, etc - systems explicitly designed so that
new hardware will boot old OSs.

Jason
