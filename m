From: rogerq@ti.com (Roger Quadros)
Date: Wed, 7 May 2014 15:06:14 +0300
Subject: [PATCH V5 0/3] arm: dts: dra7: Updates for adding crossbar device
In-Reply-To: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
References: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
Message-ID: <536A21B6.9040900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 04:56 PM, Sricharan R wrote:
> Some socs have a large number of interrupts requests to service
> the needs of its many peripherals and subsystems. All of the interrupt
> requests lines from the subsystems are not needed at the same
> time, so they have to be muxed to the controllers appropriately.
> In such places a interrupt controllers are preceded by an
> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
> requests to the controller inputs.
> 
> The dts file update to support the crossbar device and convert
> peripheral irq numbers to crossbar number are added here.
> 
> This is a rebase of V4 series on top of 3.15-rc4
> 
> This series depends on crossbar-driver-fixes sent below
> http://marc.info/?l=linux-omap&m=139929963420299&w=2

For USB and SATA

Tested-by: Roger Quadros <rogerq@ti.com>

NOTE: I've updated the USB and SATA patches on l-o list to work with this series.

cheers,
-roger

> 
> Sricharan R (3):
>   arm: dts: dra7: Add crossbar device binding
>   arm: dts: dra7: Replace peripheral interrupt numbers with crossbar
>     inputs
>   arm: dts: dra7: Add routable-irqs property for gic node
> 
>  arch/arm/boot/dts/dra7.dtsi |  109 +++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 46 deletions(-)
> 
