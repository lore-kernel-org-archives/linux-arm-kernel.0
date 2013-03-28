From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Mar 2013 09:54:59 +0900
Subject: [PATCH v4 1/2] irqchip: intc-irqpin: Add support for shared
 interrupt lines
In-Reply-To: <1364392444-25181-1-git-send-email-hechtb+renesas@gmail.com>
References: <1364392444-25181-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130328005459.GG20736@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 02:54:03PM +0100, Bastian Hecht wrote:
> On some hardware we don't have a 1-1 mapping from the external
> interrupts coming from INTC to the GIC SPI pins. We can however
> share lines to demux incoming IRQs on these SoCs.
> 
> This patch enables the intc_irqpin driver to detect requests for shared
> interrupt lines and demuxes them properly by querying the INTC INTREQx0A
> registers.
> 
> If you need multiple shared intc_irqpin device instances, be sure to mask
> out all interrupts on the INTC that share the one line before you start
> to register them. Else you run into IRQ floods that would be caused by
> interrupts for which no handler has been set up yet when the first
> intc_irqpin device is registered.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, queued-up for v3.10 in the pinmux branch.
