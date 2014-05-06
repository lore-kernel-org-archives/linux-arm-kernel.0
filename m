From: detheridge@ti.com (Darren Etheridge)
Date: Tue, 6 May 2014 16:45:26 -0500
Subject: [PATCH V5 0/3] arm: dts: dra7: Updates for adding crossbar device
In-Reply-To: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
References: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20140506214526.GF2626@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sricharan R <r.sricharan@ti.com> wrote on Tue [2014-May-06 19:26:16 +0530]:
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
> 
> Sricharan R (3):
>   arm: dts: dra7: Add crossbar device binding
>   arm: dts: dra7: Replace peripheral interrupt numbers with crossbar
>     inputs
>   arm: dts: dra7: Add routable-irqs property for gic node
> 

OK, assuming the bisectability issues discussed earlier on this thread
are addressed.  I have tested the earlier crossbar patch series in
conjunction with this dts series with VIP capture and DSS display
running together on DRA7.  Looks good with this combination of
devices. VIP is one of the modules that must have a crossbar mapping as
there is no default interrupt mapping for it, therefore VIP makes a good
test case.

So please feel free to add:

Tested-by: Darren Etheridge <detheridge@ti.com>


>  arch/arm/boot/dts/dra7.dtsi |  109 +++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 46 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
