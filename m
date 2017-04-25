From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 25 Apr 2017 12:41:28 +0300
Subject: [PATCH 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <20170424215022.30382-3-eric@anholt.net>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-3-eric@anholt.net>
Message-ID: <86e911e7-ca92-af6e-8efb-812ee1939320@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2017 12:50 AM, Eric Anholt wrote:

> Cygnus has a single amac controller connected to the B53 switch with 2
> PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
> the external ethernet jacks.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi      | 60 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm911360_entphn.dts |  8 +++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 009f1346b817..318899df9972 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
[...]
> @@ -295,6 +345,16 @@
>  			status = "disabled";
>  		};
>
> +		eth0: enet at 18042000 {

    Oh, and this one should be named "ethernet", according to the DT spec.

> +			compatible = "brcm,amac";
> +			reg = <0x18042000 0x1000>,
> +			      <0x18110000 0x1000>;
> +			reg-names = "amac_base", "idm_base";
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			max-speed = <1000>;
> +			status = "disabled";
> +		};
> +
>  		nand: nand at 18046000 {
>  			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
>  			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
[...]

MBR, Sergei
