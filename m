From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 23 Jun 2014 15:05:19 +0200
Subject: [PATCH v6 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <53A0861E.90400@gmail.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
 <1402914392-6028-2-git-send-email-antoine.tenart@free-electrons.com>
 <53A0861E.90400@gmail.com>
Message-ID: <20140623130519.GA23540@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Tue, Jun 17, 2014 at 08:17:02PM +0200, Sebastian Hesselbarth wrote:
> On 06/16/2014 12:26 PM, Antoine T?nart wrote:
> > +
> > +#define PHY_BASE		0x200
> 
> Antoine,
> 
> I gave your Berlin AHCI patches a try on BG2. I finally got it working
> but BG2 has a different PHY_BASE and need some register fixups.
> 
> Please update this patch and the DT bindings to reflect the difference
> of BG2Q with respect to BG2 as below.
> 
> [...]
> > +
> > +static const struct of_device_id phy_berlin_sata_of_match[] = {
> > +	{ .compatible = "marvell,berlin-sata-phy" },
> 
> s/marvell,berlin-sata-phy/marvell,berlin2-sata-phy/
> 
> and add
> 
> marvell,berlin2q-sata-phy
> 
> That way it can be applied now without proper support for BG2
> and I can send patches later.

Sure. I'll just s/marvell,berlin-sata-phy/marvell,berlin2q-sata-phy/ so
we don't have a non working compatible.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
