From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 10:19:17 -0400
Subject: [RFC PATCH 0/6] DRIVERS: IRQCHIP: Add support for crossbar IP
In-Reply-To: <1380549564-31045-1-git-send-email-r.sricharan@ti.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com>
Message-ID: <52498865.5030303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 September 2013 09:59 AM, Sricharan R wrote:
> Some socs have a large number of interrupts requests to service
> the needs of its many peripherals and subsystems. All of the interrupt
> requests lines from the subsystems are not needed at the same
> time, so they have to be muxed to the controllers appropriately.
> In such places a interrupt controllers are preceded by an
> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
> requests to the controller inputs.
> 
> This series models the peripheral interrupts that can be routed through
> the crossbar to the GIC as 'routable-irqs'. The routable irqs are added
> in a separate linear domain inside the GIC. The registered routable domain's
> callback are invoked as a part of the GIC's callback, which in turn should
> allocate a free irq line and configure the IP accordingly. So every peripheral
> in the dts files mentions the fixed crossbar number as its interrupt. A free
> gic line for that gets allocated and configured when the peripheral's interrupt
> is mapped.
> 
> The minimal crossbar driver to track and allocate free GIC lines and configure the
> crossbar is added here, along with the DT bindings.
> 
You should have references to the previous discussions so that its
easier for new reviewers to understand why you ended up the approach.
I noticed you missed this in your last posts as well.

Regards,
Santosh
