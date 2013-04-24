From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 24 Apr 2013 19:13:15 +0100
Subject: [Xen-devel] [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.LFD.2.03.1304221151200.17375@syhkavp.arg>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181237480.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304181749260.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181336280.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304191035360.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304191146230.17375@syhkavp.arg>
 <1366388166.29403.2.camel@dagon.hellion.org.uk>
 <alpine.LFD.2.03.1304191223280.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304191739120.7254@kaball.uk.xensource.com>
 <1366644069.20256.8.camel@zakaz.uk.xensource.com>
 <alpine.LFD.2.03.1304221151200.17375@syhkavp.arg>
Message-ID: <alpine.DEB.2.02.1304241911420.4180@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Apr 2013, Nicolas Pitre wrote:
> > I think the key thing that non-Xen folks aren't aware of is that
> > although Xen passes the majority of the underlying hardware to the dom0
> > kernel to manage one of the few things it does not expose to guests
> > (where "guests" includes dom0) is the SMP topology of the underlying system.
> 
> I suspect it is unlikely to pass on the DT information about the CCI 
> either.  Which means that, in the case that started this thread, the 
> smp_init function needed by MCPM will simply return false and the next 
> priority in the list i.e. plain PSCI will be initialized instead.
> 
> I don't forsee the need to poke at the hardware directly within 
> ->smp_init, not since everything is moving to DT now.
> 
> Sure there are ways to screw up Xen support from within this hook, but 
> that can be achieved in many other places.  Will Xen take over every 
> possible hooks in the kernel to prevent that from happening?
> 
> So please let's not cry wolf needlessly.

OK, you convinced me :-)
I'll drop the patch.
