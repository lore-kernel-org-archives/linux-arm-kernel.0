From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Mar 2013 12:03:54 -0400 (EDT)
Subject: [PATCH v2 6/6] [RFC] arm: use PSCI if available
In-Reply-To: <201303261546.50194.arnd@arndb.de>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1303261509080.4430@kaball.uk.xensource.com>
 <20130326153730.GA22368@mudshark.cambridge.arm.com>
 <201303261546.50194.arnd@arndb.de>
Message-ID: <alpine.LFD.2.03.1303261201530.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013, Arnd Bergmann wrote:

> On Tuesday 26 March 2013, Will Deacon wrote:
> > > They can even base the implementation of their smp_ops on the current
> > > psci code, in order to facilitate that I could get rid of psci_ops
> > > (which initialization is based on device tree) and export the psci_cpu_*
> > > functions instead, so that they can be called directly by other smp_ops.
> > 
> > Again, I think this destroys the layering. The whole point is that the PSCI
> > functions are called from within something that understands precisely how to
> > talk to the firmware and what it is capable of.
> 
> Right, we probably the psci smp ops to be separate from the rest of the psci
> code, but I also think that Stefano is right that we should let any platform
> use the psci smp ops if possible, rather than having to implement their own.

Oh absolutely.  It is always best to use an existing standard.  But PSCI 
probably won't be the only firmware interface standard.  It therefore 
shouldn't be used as the Linux internal interface model.


Nicolas
