From: stefan@agner.ch (Stefan Agner)
Date: Thu, 02 Jul 2015 15:34:58 +0200
Subject: [RFC PATCH 1/7] ARM: dts: vf610: Add missing QuadSPI register
 mapping and names.
In-Reply-To: <1435782010-9809-3-git-send-email-cory.tusar@pid1solutions.com>
References: <1435782010-9809-1-git-send-email-cory.tusar@pid1solutions.com>
 <1435782010-9809-3-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <cfce9c6cf3d8f1cab843ec4aed37e1f5@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-07-01 22:20, Cory Tusar wrote:
> Both 'reg' and 'reg-names' are required properties according to binding
> documentation, and both should contain two items.
> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 4aa3351..089a263 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -242,7 +242,8 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,vf610-qspi";
> -				reg = <0x40044000 0x1000>;
> +				reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
> +				reg-names = "QuadSPI", "QuadSPI-memory";
>  				interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks VF610_CLK_QSPI0_EN>,
>  					<&clks VF610_CLK_QSPI0>;

Hm, this seem to have been wrong since the beginning...

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan
