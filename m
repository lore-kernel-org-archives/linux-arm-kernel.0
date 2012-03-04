From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Mar 2012 18:42:29 +0100
Subject: [PATCH v5 4/4] clk: basic clock hardware types
In-Reply-To: <1330763341-3437-5-git-send-email-mturquette@linaro.org>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-5-git-send-email-mturquette@linaro.org>
Message-ID: <20120304174229.GD11546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 12:29:01AM -0800, Mike Turquette wrote:
> Many platforms support simple gateable clocks, fixed-rate clocks,
> adjustable divider clocks and multi-parent multiplexer clocks.
> 
> This patch introduces basic clock types for the above-mentioned hardware
> which share some common characteristics.

Hi Mike

These basic clocks don't allow the use of prepare/unprepare, from the
side of the clock provider. I think i need this.

The Orion Kirkwood SoC has clock gating for most of its on chip
peripherals, which the other older Orion devices don't have. The SATA
and PCIe also allows the PHY to be shut down, again which older Orion
devices don't have. The current code links the clock and the PHY
together, shutting both down are the same time. So i would like to
perform the PHY shutdown in the unprepare() function of the clk
driver.

Is allowing to pass prepare/unprepare functions to basic clocks
something you want to support? If i prepare a patch would you consider
it?

	Thanks
		Andrew
