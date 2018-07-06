From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Jul 2018 17:49:34 +0100
Subject: [PATCH 1/3 v3] ARM: dts: Modernize the Vexpress PL111 integration
In-Reply-To: <20180628133648.6765-1-linus.walleij@linaro.org>
References: <20180628133648.6765-1-linus.walleij@linaro.org>
Message-ID: <d9dae965-90e4-14f5-e933-17404e1837e1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/06/18 14:36, Linus Walleij wrote:
> The Versatile Express was submitted with the actual display
> bridges unconnected (but defined in the device tree) and
> mock "panels" encoded in the device tree node of the PL111
> controller.
> 
> This doesn't even remotely describe the actual Versatile
> Express hardware. Exploit the SiI9022 bridge by connecting
> the PL111 pads to it, making it use EDID or fallback values
> to drive the monitor.
> 
> The  also has to use the reserved memory through the
> CMA pool rather than by open coding a memory region and
> remapping it explicitly in the driver. To achieve this,
> a reserved-memory node must exist in the root of the
> device tree, so we need to pull that out of the
> motherboard .dtsi include files, and push it into each
> top-level device tree instead.
> 
> We do the same manouver for all the Versatile Express
> boards, taking into account the different location of the
> video RAM depending on which chip select is used on
> each platform.
> 
> This plays nicely with the new PL111 DRM driver and
> follows the standard ways of assigning bridges and
> memory pools for graphics.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mali DP Maintainers <malidp@foss.arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Add some reg = <0>; to the ports to make the DTC happy.
> - Add reserved memory node to
>   arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
>   as well.
> ChangeLog v1->v2:
> - Fix up the memory address for the -rs1 tiles to 0x18000000
> - Drop a bunch of extraneous reg props from the DVI adapter
> ---
>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi       | 45 ++++++------------
>  arch/arm/boot/dts/vexpress-v2m.dtsi           | 46 ++++++-------------
>  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts   | 14 ++++++
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    | 14 ++++++
>  arch/arm/boot/dts/vexpress-v2p-ca5s.dts       | 14 ++++++
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts        | 41 +++++++----------
>  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    | 14 ++++++

Still fails to build above DTS.

>  .../boot/dts/arm/rtsm_ve-motherboard.dtsi     | 37 ++-------------
>  .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 14 ++++++
>  9 files changed, 121 insertions(+), 118 deletions(-)
> 

Also I am getting lots of new warnings.

I tried applying these patches and saw above 2 issues, not looked
at the errors yet, just thought will give you heads up.

--
Regards,
Sudeep

-- 
Regards,
Sudeep
