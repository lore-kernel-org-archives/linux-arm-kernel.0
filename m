From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Jan 2017 04:06:01 +0100
Subject: mvneta MDIO problems
In-Reply-To: <20170130103628.09178f50@free-electrons.com>
References: <1485351412.5441.82.camel@beck.ac>
 <20170130103628.09178f50@free-electrons.com>
Message-ID: <20170131030601.GD21740@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > After some days (1-20 ?) uptime, the kernel 4.8.11 logs:
> > 
> > [779752.514644] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > [783518.193094] mvneta d0070000.ethernet eth0: Link is Down
> > [783519.229922] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > [789431.374474] mvneta d0070000.ethernet eth0: Link is Down
> > [804522.151348] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > [804530.474111] mvneta d0070000.ethernet eth0: Link is Down
> > [804532.550916] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > [806254.718708] mvneta d0070000.ethernet eth0: Link is Down
> > 
> > ... so sooner or later, the link stays down (let's call this "failed state")

I've not seen this, but i blew my mirabox up, wrong power supply :-(

I've also not heard of problems with other Marvell devices. So i would
guess it is something specific to this SoC and PHY.

> > I have no idea on how to debug this... the system is currently in
> > "failed state", kernel source and compiler are available on the box
> > (e.g. for unloading, modifying, compiling and loading mvneta.ko again),
> > which is currently "offline", but can be accessed through the serial
> > console.

Does you kernel have:

commit e22e996b72d47c7bf5bb6b17071b2e9d3db462d4
Author: Uwe Kleine-K??nig <uwe@kleine-koenig.org>
Date:   Tue Nov 22 16:47:11 2016 +0100

    net/phy: add trace events for mdio accesses
    
    Make it possible to generate trace events for mdio read and write accesses.

and are trace points compiled in? I've never used it, but it should be
possible to log the mdio reads/writes. I would be interested to see
the values. Reads of 0xffff indicate the PHY did not answer at all. Or
are there bit flips?

    Andrew
