From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Apr 2012 21:36:44 +0200
Subject: [PATCH 07/17] ARM: kirkwood: use machine specific hook for late init
Message-ID: <20120426193644.GA17250@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn

You can probably drop this patch. The move to common clock framework
removes late_initcall(kirkwood_clock_gate). The common clock framework
late init call is used instead to turn off all clocks which are no
longer in use.

Take a look at:

https://lunn at github.com/lunn/orion-clk.git branch v3.4-rc4-clk-orion

I also have a version rebased on Mike clk-next tree, but i'm waiting
for the discussion about what clk-next should be based on, before
you again rebasing and posting my patches.

	Andrew
