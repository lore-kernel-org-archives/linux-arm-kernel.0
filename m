From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Aug 2018 18:38:05 +0200
Subject: [PATCH] arm64: dts: add support for SolidRun Clearfog GT 8K
In-Reply-To: <871sahxk4s.fsf@tkos.co.il>
References: <3276b82491c1eda1e05a0e6b94560cfa451cf8d4.1535544789.git.baruch@tkos.co.il>
 <20180829141159.GB22270@lunn.ch> <8736uxxmai.fsf@tkos.co.il>
 <20180829150942.GD22270@lunn.ch> <871sahxk4s.fsf@tkos.co.il>
Message-ID: <20180829163805.GE22270@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I see this from phylink_mac_config():
> 
> [  511.043783] mvpp2 f4000000.ethernet eth2: phylink_mac_config: mode=fixed/2500base-x/2.5Gbps/Full adv=00000,00008200 pause=10 link=1 an=1
> 
> Is that enough for a test?

That shows you what the mvpp2 is being asked to do. But not what the
switch is doing. It could be the two SERDES interfaces are doing
auto-neg, and ended up at 1G.

Try actually pushing traffic over the switch. Two iperf instances, out
two ports. Do you get 1Gbps for each stream or 500Mbps?

In the end, it does not matter. We want the CPU port of the switch to
default to its maximum speed. So you should not need a fixed-link. But
until the patch is applied, i don't think it will do > 1Gbps.

      Andrew
