From: B38611@freescale.com (Duan Fugang-B38611)
Date: Tue, 10 Sep 2013 03:23:26 +0000
Subject: [PATCH v2 2/4] ARM: dts: add fec phy reset for imx6sl evk board
In-Reply-To: <20130910031138.GD5815@S2101-09.ap.freescale.net>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
 <1378182385-9205-3-git-send-email-B38611@freescale.com>
 <20130909145333.GA5815@S2101-09.ap.freescale.net>
 <9848F2DB572E5649BA045B288BE08FBE016A7AB8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20130910031138.GD5815@S2101-09.ap.freescale.net>
Message-ID: <9848F2DB572E5649BA045B288BE08FBE016A8DF9@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo [mailto:shawn.guo at linaro.org]
Data: Tuesday, September 10, 2013 11:12 AM + 800

> To: Duan Fugang-B38611
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/4] ARM: dts: add fec phy reset for imx6sl evk
> board
> 
> On Tue, Sep 10, 2013 at 01:26:49AM +0000, Duan Fugang-B38611 wrote:
> > Shawn, you cannot drop this patch.
> 
> I have to drop the patch *for now*.  Look, with the patch landed on linux-
> next, people report that fec is broken as below on imx6sl-evk.
> 
> fec 2188000.ethernet eth0: no PHY, assuming direct connection to switch
> libphy: PHY fixed-0:00 not found
> fec 2188000.ethernet eth0: could not attach to PHY
> IP-Config: Failed to open eth0
> IP-Config: No network devices available
> 
> While before the patch, we can boot the board into console with NFS when
> downloading kernel image from network.  This is the most used setup for
> kernel developers.
> 
> > 1. Why do you get a working fec driver in kernel if U-Boot sets it up
> properly ?
> >    Because the phy reset done by uboot, kernel cannot depend on uboot.
> >    And even so, the driver still have problem for unit test.
> 
> Yeah, it should be fixed/improved without any breakage/regression on the
> current use case.
> 
> > 2. You see freescale internal kernel(3.10.9) work fine. There have one
> driver patch don't upstream.
> >    I will send it out to net tree for review.
> 
> That's where problem comes.  You should push required driver changes
> upstream before sending me this patch.  You need to resolve the
> dependencies between patches properly without introducing any breakages or
> regressions.
> 
Ok, you can drop the patch. After fec driver patch with phy reset applied, and then apply it.

In fact, just for kernel, there have no sequence between the patch and driver patch because
Kernel fec also cannot work for imx6sl evk if uboot don't do the initial.

> That said, I'm not saying the patch is wrong, but the timing of sending
> this patch for merging is wrong.
> 
> Shawn
