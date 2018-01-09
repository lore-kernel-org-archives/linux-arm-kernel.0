From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 9 Jan 2018 16:11:50 +0100
Subject: [PATCH net-next v3 4/4] net: mvpp2: 2500baseX support
In-Reply-To: <20180109144238.GH17719@n2100.armlinux.org.uk>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
 <20180109085945.11916-5-antoine.tenart@free-electrons.com>
 <20180109144238.GH17719@n2100.armlinux.org.uk>
Message-ID: <20180109151150.GA23676@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 09, 2018 at 02:42:38PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 09, 2018 at 09:59:45AM +0100, Antoine Tenart wrote:
> > This patch adds the 2500Base-X PHY mode support in the Marvell PPv2
> > driver. 2500Base-X is quite close to 1000Base-X and SGMII modes and uses
> > nearly the same code path.
> 
> For 2500Base-X, do you report a speed of 2500Mbps through ethtool, or
> are you reporting 1000Mbps?  I don't see any code in this patch that
> deals with that.

The mvpp2 driver uses phy_ethtool_get_link_ksettings() to report the
link speed to Ethtool. So it's reporting the speed set by the PHY
driver.

So it'll be something to ensure when adding PHYs supporting the mode.
We'll have the opportunity to see this when adding the last mcbin
interface.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
