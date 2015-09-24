From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 25 Sep 2015 00:26:54 +0200
Subject: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
In-Reply-To: <20150924.151554.619662567057050978.davem@davemloft.net>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <20150924215731.GE20825@lunn.ch>
 <20150924.151554.619662567057050978.davem@davemloft.net>
Message-ID: <20150924222654.GG20825@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 03:15:54PM -0700, David Miller wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Thu, 24 Sep 2015 23:57:31 +0200
> 
> > I built the FEC driver as a module, and it won't unload:
> > 
> >  kernel:unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> > 
> > i assume because DSA holds a reference. I've not tried a fully module
> > build, DSA has issues with that.
> > 
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> So, is this a regression?

Sorry, worded that badly. Since DSA is still active, it should not be
possible to unload the FEC driver. DSA should have a reference to it,
and mdio-mux also should have a reference to the mdio bus of the FEC
driver.

As Russell requested, i will re-test without his patches, just to make
sure.

	Andrew
