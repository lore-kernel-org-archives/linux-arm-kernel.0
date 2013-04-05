From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Apr 2013 15:41:36 -0400 (EDT)
Subject: [PATCH v6 4/4] xen/arm: introduce xen_early_init, use PSCI on xen
In-Reply-To: <alpine.DEB.2.02.1304051825390.21065@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1304051217560.1171@syhkavp.arg>
 <alpine.DEB.2.02.1304051725580.21065@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1304051825390.21065@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1304051536250.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Stefano Stabellini wrote:

> On Fri, 5 Apr 2013, Stefano Stabellini wrote:
> > - we are running on Xen
> > Xen is running on the platform, we are running as a guest on Xen and an
> > hypervisor node is available on device tree.
> > Let's also assume that there aren't any "arm,cci" compatible nodes on
> > device tree because Xen wouldn't export this kind of information to any
> > guests right now. Therefore PSCI should be used to boot secondary cpus.
> 
> Just in case this isn't clear enough: we don't have big.LITTLE support 
> in Xen right now, not in the hypervisor and certainly not in guests. 
> I'm keen on having big.LITTLE support in the hypervisor (thus some 
> code similar to your MCPM patch series will probably end up in Xen at 
> some point) but I doubt we'll expose big.LITTLE to guests any time 
> soon. It's going to be years, so I am not particularly worried about 
> it right now.

I fully understand that it is unlikely that a Xen guest will "see" a 
big.LITTLE environment in the near future.

My concern is about a kernel that is _configured_ to run either on a 
native VExpress machine that might or might not be b.L, or as a Xen 
guest, in the same zImage binary.


Nicolas
