From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 13:33:05 -0500 (EST)
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <8yahbdoh6fs.fsf@huya.qualcomm.com>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
	<20110104084517.GA9791@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101040926100.22191@xanadu.home>
	<20110104165347.GA24935@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041225070.22191@xanadu.home>
	<20110104180620.GC24935@n2100.arm.linux.org.uk>
	<8yahbdoh6fs.fsf@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1101041330450.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, David Brown wrote:

> On Tue, Jan 04 2011, Russell King - ARM Linux wrote:
> 
> > On Tue, Jan 04, 2011 at 12:50:28PM -0500, Nicolas Pitre wrote:
> 
> > You're making a mountain out of a mole hill.  At present, there is one
> > platform which defines its own complex v:p mapping and that is Realview,
> > but only when sparsemem is enabled.  As already mentioned, MSM is the
> > only other platform which can't use this method.  So that's a simple
> > dependency line against the config.
> 
> This is unfortunate, however, for us, since it would keep us having all
> of our targets having to be built exclusively.
> 
> Any idea how much it would hurt other targets to have the
> __virt_to_phys() and __phys_to_virt() have a 16-bit fixup, even if only
> the upper 8 bits are used?

Probably not that much.  But let's make it work satisfactorily for the 
general case first, and then we might consider and test variations that 
could accommodate msm.


Nicolas
