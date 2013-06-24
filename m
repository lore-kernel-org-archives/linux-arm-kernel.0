From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 14:51:26 +0800
Subject: [RFC PATCH] ARM i.MX53: Fix UART pad configuration
In-Reply-To: <1371821771-23450-1-git-send-email-p.zabel@pengutronix.de>
References: <1371821771-23450-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130624065125.GB26254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 03:36:11PM +0200, Philipp Zabel wrote:
> The current default pad configuration for UART RX and TX pads sets a 360k
> pull-down and writes 1 to a reserved bit (1 << 0). It doesn't seem right to
> me that in idle state, the UART has to keep the signal high against a
> pull-down resistor.
> 
> This patch instead sets a 100k pull-up, which incidentally corresponds to the
> register reset value for all but one (MX53_PAD_KEY_ROW0__UART4_RXD_MUX) pad,
> and removes the write to the reserved bit.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Or is there a valid reason to set a pull-down on those pads and to write 1
> to the reserved bit?

IIRC, the setting was inherited from non-DT kernel.

Applied as a fix for 3.11.

Shawn
