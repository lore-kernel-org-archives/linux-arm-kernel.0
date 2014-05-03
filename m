From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 3 May 2014 16:40:33 +0200
Subject: Automatically detecting when to use kirkwood-tsXXX-6281.dtb vs
 -6282.dtb (Was: Re: [PATCH 21/21] ARM: Kirkwood: Remove DT support)
In-Reply-To: <1399123167.23380.163.camel@dagon.hellion.org.uk>
References: <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <20140220111913.GZ21483@n2100.arm.linux.org.uk>
 <1392896356.23342.40.camel@kazak.uk.xensource.com>
 <20140220232649.GU7862@titan.lakedaemon.net>
 <1393257630.16570.95.camel@kazak.uk.xensource.com>
 <20140224162413.GE18601@lunn.ch>
 <1399123167.23380.163.camel@dagon.hellion.org.uk>
Message-ID: <20140503144033.GD19833@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However on my 6281 based TS-219 system there seems to be no visible PCI
> bus when running the 3.2 kernel in the current Debian stable release
> (which of course uses board support). Some info:

The old PCI driver looks to see if there is anything on the bus, and
if not, does not register the PCI bus to the PCI core. The new PCI
driver always registers the busses, allowing hotplug of PCI devices.

> Is the lack of anything on the PCI bus itself sufficient to determine
> that this is a 6281 based ts219 rather than a 6282 one (I don't have any
> 6282 ts219 systems to try)?

No, this is not sufficient, as far as i know. I have a 6282 based
ts119. It also does not have any PCI devices. However, the 6282 DT
file works fine on it. There is no need to differentiate between 119
and 219, just between 6281 and 6282.

Your idea about Ethernet PHY is probably the best way to tell them
apart. But i will see if i can find anything else.

    Andrew
