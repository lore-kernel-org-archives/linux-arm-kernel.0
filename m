From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 23 Aug 2017 10:52:23 +0100
Subject: [PATCH v2] arm64: dts: marvell: add Device Tree files for
 Armada-8KP
In-Reply-To: <1502364534-20732-1-git-send-email-hannah@marvell.com>
References: <1502364534-20732-1-git-send-email-hannah@marvell.com>
Message-ID: <deba07ea-3033-e224-e98a-62072687e673@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Thomas for pointing me to this patch.

Hannah: in the future, please include  whoever commented on your patch
when you respin it.

On 10/08/17 12:28, hannah at marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> This commit adds the base Device Tree files for the Armada 8KPlus.
> The Armada 8KP SoCs include several hardware blocks, and this
> commit only adds support for the AP810 block, that contains the CPU
> core and basic peripherals.
> 
> AP810 is a high-performance die, includes octal core application
> processor based ARMv8-A architecture, two standard high speed DDR4
> interface, and GIC-600 interrupt controller.
> AP810 Built as part of Marvell?s MoChi AP family products.
> 
> Armada-8080 (8KPlus family), include an AP810 block that contains
> the CPU core and basic peripherals.
> 
> This commit creates the following hierarchy:
>  * armada-ap810-ap0.dtsi - definitions common to AP810
>  	* armada-ap810-ap0-octa-core.dtsi - description of the octa cores
> 		* armada-8080.dtsi - description of the 8080 SoC
> 			* armada-8080-db.dts - description of the 8080 board
> 
> Change-Id: I34ff3dc5d686b048477d953278622d74eaef843d

Please drop this Change-Id from mainline submissions, as we don't carry
such tags.

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> ---
> 
> Notes:
> 	Changes in v2:
> 	- remove affininty mask for PPI
> 	- add missing regions in GIC address space (GICC, GICH, and GICV)
> 
>  .../devicetree/bindings/arm/marvell/armada-8kp.txt |  15 ++
>  arch/arm64/boot/dts/marvell/Makefile               |   1 +
>  arch/arm64/boot/dts/marvell/armada-8080-db.dts     |  67 +++++++++
>  arch/arm64/boot/dts/marvell/armada-8080.dtsi       |  53 +++++++
>  .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    | 104 +++++++++++++
>  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  | 163 +++++++++++++++++++++
>  6 files changed, 403 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8080-db.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8080.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
