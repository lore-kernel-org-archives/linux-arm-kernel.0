From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 13:33:05 -0700
Subject: [PATCH 06/28] gpio: Renesas R-Car GPIO driver V3
In-Reply-To: <1364879376-10020-7-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
 <1364879376-10020-7-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130402203305.GD8015@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:09:14PM +0900, Simon Horman wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch is V3 of a GPIO driver for the R-Car series of
> SoCs from Renesas. This driver is designed to be reusable
> between multiple SoCs that share the same basic building block,
> but so far it has only been used on R-Car H1 (r8a7779).
> 
> Each driver instance handles 32 GPIOs with individually
> maskable IRQs. The driver operates on a single I/O memory
> range and the 32 GPIOs are hooked up a single interrupt.
> 
> In the case of R-Car H1 either external IRQ pins or GPIOs
> with interrupts can be used for on-board interupts. For
> external IRQs 4 pins are supported, and in the case of GPIO
> there are 202 GPIOS as 202 interrupts hooked up via 6 driver
> instances and to the GIC and the Cortex-A9 Quad.
> 
> At this point this driver is interfacing as a regular
> platform device driver. In the future DT support will be
> submitted as an incremental feature patch.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Hmm, you seem to not be collecting tags on patches or at least missed
one here. This patch, when posted, got a Reviewed-by from LinusW. I
caught it mostly since it had no ack (or reviewed) from the subsystem
maintainer in this case.

Please rebuild and resend with reviewed/acked tags as you've received
them, please.


Thanks!

-Olof
