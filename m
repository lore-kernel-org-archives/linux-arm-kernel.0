From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Apr 2013 17:10:12 +0100
Subject: [PATCH v8 1/2] arm: introduce psci_smp_ops
In-Reply-To: <alpine.DEB.2.02.1304261630110.4180@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304241935010.4180@kaball.uk.xensource.com>
 <1366828819-10745-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130425084711.GA12848@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1304251104090.4180@kaball.uk.xensource.com>
 <20130425104508.GG12848@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1304251054420.1258@syhkavp.arg>
 <alpine.DEB.2.02.1304261630110.4180@kaball.uk.xensource.com>
Message-ID: <20130426161012.GH30858@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 04:36:26PM +0100, Stefano Stabellini wrote:
> On Thu, 25 Apr 2013, Nicolas Pitre wrote:
> > On Thu, 25 Apr 2013, Will Deacon wrote:
> > > I disagree. You're explicitly stating that we pass the `cpuid of target CPU,
> > > as from MPIDR'. That's simply not true -- the firmware could choose any
> > > numbering scheme to identify the CPUs. For KVM and Xen, it *is* the mpidr,
> > > which is why psci-smp.c works at all, but that's where the comment belongs,
> > > not in this header file.
> > 
> > At some point, the _kernel_ API for interfacing with the firmware's PSCI 
> > will have to ensure uniformity somehow.  The PSCI interface code could 
> > translate the passed MPIDR into whatever the firmware decided to use for 
> > identifying CPUs if needed, keeping this issue localized.
> 
> That is what I had in mind when I said to keep the comment in psci.h
> before.
> We have to draw the line somewhere to expose a uniform internal kernel
> API. However it is a bit difficult to do now given that we have only one
> user of the API.

I see psci.h as representing the firmware interface, and psci-smp.c or
whatever sits on top as exposing the kernel `API'.

> I don't feel to strongly about this, please let me know what is the
> final decision and I'll update the code accordingly. I remind you that
> the merge window is approaching :-)

I'd still like the comment to be in psci-smp.c, or a header separate from
the firmware bits.

Will
