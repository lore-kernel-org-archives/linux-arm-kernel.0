From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 10 Apr 2012 00:29:03 +0200
Subject: COMMON_CLK_DISABLE_UNUSED
Message-ID: <20120409222903.GA31622@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike

I've been thinking about:

config COMMON_CLK_DISABLE_UNUSED
        bool "Disabled unused clocks at boot"
        depends on COMMON_CLK
        ---help---
          Traverses the entire clock tree and disables any clocks that are
          enabled in hardware but have not been enabled by any device drivers.
          This saves power and keeps the software model of the clock in line
          with reality.

          If in doubt, say "N".

I think in the long run, having this as an option is going to cause
problems, in particular for the One ARM Kernel. Some platforms are
going to want it enabled, others will want it disabled. Depending on
who looses out, there are going to be power regressions, or clocks
unexpectedly turned off.

I think it would be good to consider deleting this config option and
just have the code always enabled.

What do you think?

     Thanks
	Andrew
