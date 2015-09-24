From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 25 Sep 2015 00:50:33 +0200
Subject: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
In-Reply-To: <20150924221541.GF21513@n2100.arm.linux.org.uk>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <20150924215731.GE20825@lunn.ch>
 <20150924221541.GF21513@n2100.arm.linux.org.uk>
Message-ID: <20150924225033.GI20825@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks for testing.  Please could you confirm whether the same behaviour
> is observed without the patches, just to make absolutely sure that isn't
> a regression.

So i tested this now.

I have two FEC interfaces. One i my main access interface, and the
second is used by DSA to access switches. With your patches, the
module Used by count is equal to the number of interfaces which are
up.

Without your patches, the count is always 0.

When i try to remove the fec module, without your patches, but DSA
still using the interface, i get the same

 kernel:unregister_netdevice: waiting for eth1 to become free. Usage count = 1

as with your patch. So this is not a regression.

   Andrew
