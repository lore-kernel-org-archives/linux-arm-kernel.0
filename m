From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 20 Jun 2012 01:06:10 +0200
Subject: Dove clock support
In-Reply-To: <4FE0E753.3010105@googlemail.com>
References: <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch>
 <20120618214143.GA20040@schnuecks.de>
 <4FDFA748.10905@googlemail.com> <20120619193251.GR26034@lunn.ch>
 <20120619204210.GA18128@schnuecks.de>
 <4FE0E753.3010105@googlemail.com>
Message-ID: <20120619230610.GA3210@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 10:55:47PM +0200, Sebastian Hesselbarh wrote:
> On 06/19/2012 10:42 PM, Simon Baatz wrote:
> >Should we make this symmetric and add an enable function to gate_fn?
> 
> I also thought about that issue and I think that as long as PHY is
> controlled by controller specific registers it should be handled
> by the driver and not by common clock framework.
> 
> This is true for SATA and PCIe and will also remove the need for
> gate_fn - as long as it doen't break other orion-based SoCs. ...

If PHY control is part of the driver, where do we turn off PHYs that
are on by default and that we don't use?

Don't we still need something like gate_fn or the clk gate/phy gate
parent/child mechanism you propose?

- Simon
