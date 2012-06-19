From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarh)
Date: Tue, 19 Jun 2012 22:55:47 +0200
Subject: Dove clock support
In-Reply-To: <20120619204210.GA18128@schnuecks.de>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <20120618214143.GA20040@schnuecks.de>
 <4FDFA748.10905@googlemail.com> <20120619193251.GR26034@lunn.ch>
 <20120619204210.GA18128@schnuecks.de>
Message-ID: <4FE0E753.3010105@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2012 10:42 PM, Simon Baatz wrote:
> Should we make this symmetric and add an enable function to gate_fn?

I also thought about that issue and I think that as long as PHY is
controlled by controller specific registers it should be handled
by the driver and not by common clock framework.

This is true for SATA and PCIe and will also remove the need for
gate_fn - as long as it doen't break other orion-based SoCs. With
ge00 on dove this is different as ge PHY is not part of the SoC
but an external chip. To turn off the external clock a clk-gate
will be required for the ge PHY bit in dove's clock control
register. This should also be a child of ge controller clock to
turn both off.

Sebastian
