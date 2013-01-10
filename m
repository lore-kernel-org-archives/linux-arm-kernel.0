From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 10 Jan 2013 09:34:47 +0100
Subject: [PATCH 00/14] Rewrite Tegra PCIe driver
In-Reply-To: <20130110065537.GC15212@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109222517.3c590553@skate>
 <20130110065537.GC15212@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130110093447.646ed07c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Thu, 10 Jan 2013 07:55:37 +0100, Thierry Reding wrote:

> The reason is that with the latest bindings the matching of root ports
> to device tree nodes works as-is and nothing else indicates that the
> emulated host bridge is actually required to make any of this work. So
> in order not to introduce unneeded code I've left it out for now. If
> somebody decides that we actually need this host bridge (for standards
> compliance or whatnot) it could easily be added back.

Ok.

> However, before the emulated bridge implementation can be merged I think
> the PCI ID issue needs to be resolved.

Indeed. I am not sure yet how to solve that, though.

> > So, I instantiate one unique emulated Host Bridge, and then one
> > emulated PCI-to-PCI Bridge for each PCIe interface that I have.
> 
> Oh dear, that's even worse than on Tegra. The Marvell hardware doesn't
> even expose the root ports as PCI devices on the bus?

My understanding is that no, it doesn't, but I am still figuring out
many things in this PCIe topic.

> I suppose that in your case it really makes sense because you already
> need the emulated PCI-to-PCI bridges and therefore adding an emulated
> host bridge doesn't add much. As I said, for Tegra everything still
> works without, so I didn't see a reason to add needless code.

Ok, thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
