From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Dec 2012 17:24:42 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <alpine.DEB.2.02.1212111654120.17523@kaball.uk.xensource.com>
References: <20121204161113.GT23368@mudshark.cambridge.arm.com>
 <50BE28C6.2010403@gmail.com>
 <20121204171628.GF5314@mudshark.cambridge.arm.com>
 <50BE31E9.3040404@arm.com>
 <20121204173045.GI5314@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1212111558270.17523@kaball.uk.xensource.com>
 <20121211160956.GF16759@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1212111621220.17523@kaball.uk.xensource.com>
 <20121211164328.GI16759@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1212111654120.17523@kaball.uk.xensource.com>
Message-ID: <20121211172442.GJ16759@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 05:14:11PM +0000, Stefano Stabellini wrote:
> On Tue, 11 Dec 2012, Will Deacon wrote:
> > > > > On the Xen side there are not going to be any problems related to SMP
> > > > > and holding pens, because secondary CPUs only come into existence after
> > > > > the first CPU calls the HYPERVISOR_vcpu_op hypercall (still missing on
> > > > > ARM).
> > > > 
> > > > Ok. Would you be willing/able to wrap this in a PSCI interface when you do
> > > > add SMP support for ARM?
> > > 
> > > I grepped for PSCI in the Linux tree but I couldn't find anything.
> > > Also I googled for ARM PSCI and nothing of value came up. Can I find a
> > > doc that explains what PSCI is anywhere?
> > 
> > There is an initial version of the document here (requires registration):
> > 
> >   https://silver.arm.com/download/download.tm?pv=1303201
> > 
> > Note that there are some updates due to clarify things a bit in areas such
> > as function ID numbers and the PCS. Marc and I also plan to hack something up
> > in kvm/mach-virt for booting secondary CPUs.
> 
> Ideally the functionalities would be discoverable via DT, so that PSCI,
> PSCI-HVC and a paravirtualized Xen interface based on hypercalls and
> xenbus could all coexist without issues, reusing the same internal Linux
> APIs.

Agreed, I'll propose a binding once we have something off the ground.

Will
