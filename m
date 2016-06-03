From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Fri, 3 Jun 2016 19:17:38 +0530
Subject: [PATCH v2 5/7] net:mdio-mux: Add MDIO mux driver for iProc SoCs
In-Reply-To: <20160601.161805.1142999841225463527.davem@davemloft.net>
References: <1464701801-17243-1-git-send-email-pramod.kumar@broadcom.com>
 <1464701801-17243-6-git-send-email-pramod.kumar@broadcom.com>
 <20160601.161805.1142999841225463527.davem@davemloft.net>
Message-ID: <373fd6e55d940c4cfd45951dc5bedce7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

> -----Original Message-----
> From: David Miller [mailto:davem at davemloft.net]
> Sent: 02 June 2016 04:48
> To: pramod.kumar at broadcom.com
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
> catalin.marinas at arm.com; will.deacon at arm.com; kishon at ti.com;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
bcm-kernel-
> feedback-list at broadcom.com; linux-kernel at vger.kernel.org;
> netdev at vger.kernel.org
> Subject: Re: [PATCH v2 5/7] net:mdio-mux: Add MDIO mux driver for iProc
SoCs
>
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> Date: Tue, 31 May 2016 19:06:39 +0530
>
> > +static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
> > +{
> > +	u32 val;
> > +	unsigned int timeout = 1000; /* loop for 1s */
>
> Please order your local variable declarations from longest to shortest
line.
>
> > +static int start_miim_ops(void __iomem *base,
> > +			  u16 phyid, u32 reg, u16 val, u32 op) {
> > +	int ret;
> > +	u32 param;
>
> Likewise.
>
Sure. I'll take care of this in next patch for all places.

> > +static int iproc_mdiomux_read(struct mii_bus *bus, int phyid, int
> > +reg) {
> > +	int ret;
> > +	struct iproc_mdiomux_desc *md = bus->priv;
>
> Likewise.
Sure. I'll take care of this in next patch for all places.

Regards,
Pramod
