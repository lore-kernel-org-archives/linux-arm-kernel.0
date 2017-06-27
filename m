From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 27 Jun 2017 10:05:29 +0200
Subject: [PATCH v6 05/21] net-next: stmmac: Add dwmac-sun8i
In-Reply-To: <8e3d73a7-e9ff-d3e2-4bce-bcc79cdf86db@arm.com>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
 <20170531071852.12422-6-clabbe.montjoie@gmail.com>
 <8e3d73a7-e9ff-d3e2-4bce-bcc79cdf86db@arm.com>
Message-ID: <20170627080529.GA2468@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 01:18:23AM +0100, Andr? Przywara wrote:
> On 31/05/17 08:18, Corentin Labbe wrote:
> > The dwmac-sun8i is a heavy hacked version of stmmac hardware by
> > allwinner.
> > In fact the only common part is the descriptor management and the first
> > register function.
> 
> Hi,
> 
> I know I am a bit late with this, but while adapting the U-Boot driver
> to the new binding I was wondering about the internal PHY detection:
> 
> 
> So here you seem to deduce the usage of the internal PHY by the PHY
> interface specified in the DT (MII = internal, RGMII = external).
> I think I raised this question before, but isn't it perfectly legal for
> a board to use MII with an external PHY even on those SoCs that feature
> an internal PHY?
> On the first glance that does not make too much sense, but apart from
> not being the correct binding to describe all of the SoCs features I see
> two scenarios:
> 1) A board vendor might choose to not use the internal PHY because it
> has bugs, lacks features (configurability) or has other issues. For
> instance I have heard reports that the internal PHY makes the SoC go
> rather hot, possibly limiting the CPU frequency. By using an external
> MII PHY (which are still cheaper than RGMII PHYs) this can be avoided.
> 2) A PHY does not necessarily need to be directly connected to
> magnetics. Indeed quite some boards use (RG)MII to connect to a switch
> IC or some other network circuitry, for instance fibre connectors.
> 
> So I was wondering if we would need an explicit:
> 	allwinner,use-internal-phy;
> boolean DT property to signal the usage of the internal PHY?
> Alternatively we could go with the negative version:
> 	allwinner,disable-internal-phy;
> 
> Or what about introducing a new "allwinner,internal-mii-phy" compatible
> string for the *PHY* node and use that?
> 
> I just want to avoid that we introduce a binding that causes us
> headaches later. I think we can still fix this with a followup patch
> before the driver and its binding hit a release kernel.
> 
> Cheers,
> Andre.
> 

I just see some patch, where "phy-mode = internal" is valid.
I will try to find a way to use it

Regards
