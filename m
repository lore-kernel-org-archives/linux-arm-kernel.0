From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Jun 2012 15:34:13 +0000
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
Message-ID: <201206081534.13261.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 June 2012, Andrew Lunn wrote:
> Both NAND and SPI make use of the RUNIT clk. However, if neither NAND
> nor SPI is used in the system, RUNIT clock gets turned off, and the
> SoC hard locks. It appears something else in the SoC, which is not
> documented, is also using RUNIT. So prepare and enable RUNIT clock in
> kirkwood_clk_init().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

This looks bogus, because if you really need to enable that clock all
the time, we don't even need a way to turn it off.

Do you need a similar change with the 3.4 kernel before the big
change to the clock framework? If not, I would guess that there
is some other problem.

	Arnd
