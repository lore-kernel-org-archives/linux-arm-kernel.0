From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 13:59:42 +0900
Subject: [PATCH v3 1/2] irqchip: intc-irqpin: Add support for shared
 interrupt lines
In-Reply-To: <1364296699-20919-1-git-send-email-hechtb+renesas@gmail.com>
References: <1364296699-20919-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130327045942.GH25431@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 12:18:18PM +0100, Bastian Hecht wrote:
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

Thanks, I will see about queuing up these changes for v3.10.


I believe that with these changes it should be possible to rebase/rework
armadillo800eva-reference so that it no longer uses the unmerged INTC
DT bindings. Would it be possible for you to see about making a fresh
version of armadillo800eva-reference that is based on the next branch
in the Renesas tree plus this series of two patches? 
