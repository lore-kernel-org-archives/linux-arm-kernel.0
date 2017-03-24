From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Mar 2017 15:17:22 +0100
Subject: [PATCH 02/15] ARM: dts: marvell: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-2-robh@kernel.org> (Rob Herring's message
 of "Tue, 21 Mar 2017 21:03:00 -0500")
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-2-robh@kernel.org>
Message-ID: <87y3vubvyl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On mer., mars 22 2017, Rob Herring <robh@kernel.org> wrote:

> dtc recently added PCI bus checks. Fix these warnings.

Could you rebase your patch on mvebu/dt or linux-next because it doesn't
apply as is.

Thanks,

Gregory

>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants 
> to take the whole lot.
>
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt |  2 +-
>  arch/arm/boot/dts/armada-370.dtsi                   |  4 +++-
>  arch/arm/boot/dts/armada-375.dtsi                   |  4 +++-
>  arch/arm/boot/dts/armada-380.dtsi                   |  5 ++++-
>  arch/arm/boot/dts/armada-385-db-ap.dts              |  2 +-
>  arch/arm/boot/dts/armada-385-linksys.dtsi           |  2 +-
>  arch/arm/boot/dts/armada-385-turris-omnia.dts       |  2 +-
>  arch/arm/boot/dts/armada-385.dtsi                   |  6 +++++-
>  arch/arm/boot/dts/armada-388-clearfog.dts           |  2 +-
>  arch/arm/boot/dts/armada-388-clearfog.dtsi          |  2 +-
>  arch/arm/boot/dts/armada-388-db.dts                 |  2 +-
>  arch/arm/boot/dts/armada-388-gp.dts                 |  2 +-
>  arch/arm/boot/dts/armada-388-rd.dts                 |  2 +-
>  arch/arm/boot/dts/armada-390-db.dts                 |  2 +-
>  arch/arm/boot/dts/armada-395-gp.dts                 |  2 +-
>  arch/arm/boot/dts/armada-398-db.dts                 |  2 +-
>  arch/arm/boot/dts/armada-39x.dtsi                   |  6 +++++-
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi           |  3 ++-
>  arch/arm/boot/dts/armada-xp-db.dts                  |  2 +-
>  arch/arm/boot/dts/armada-xp-gp.dts                  |  2 +-
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi            |  7 ++++++-
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi            | 11 ++++++++++-
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi            | 14 ++++++++++++--
>  arch/arm/boot/dts/dove-d3plug.dts                   |  4 ++--
>  arch/arm/boot/dts/dove.dtsi                         |  8 +++++---
>  arch/arm/boot/dts/kirkwood-6192.dtsi                |  3 ++-
>  arch/arm/boot/dts/kirkwood-6281.dtsi                |  3 ++-
>  arch/arm/boot/dts/kirkwood-6282.dtsi                |  4 +++-
>  arch/arm/boot/dts/kirkwood-98dx4122.dtsi            |  3 ++-
>  29 files changed, 80 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> index 2de6f65ecfb1..e5af2e8461cf 100644
> --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> @@ -286,7 +286,7 @@ pcie-controller {
>  		status = "disabled";
>  	};
>  
> -	pcie at 10,0 {
> +	pcie at a,0 {
>  		device_type = "pci";
>  		assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
>  		reg = <0x5000 0 0 0 0>;
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index cc011c8bc36b..b9af7b22f0a0 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -72,7 +72,7 @@
>  			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
>  		};
>  
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,armada-370-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -100,6 +100,7 @@
>  				#interrupt-cells = <1>;
>                                  ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>                                            0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 58>;
>  				marvell,pcie-port = <0>;
> @@ -117,6 +118,7 @@
>  				#interrupt-cells = <1>;
>                                  ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>                                            0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 62>;
>  				marvell,pcie-port = <1>;
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index 50c5e8417802..7225c7ce9a8d 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -582,7 +582,7 @@
>  			};
>  		};
>  
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,armada-370-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -610,6 +610,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <0>;
> @@ -627,6 +628,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <0>;
> diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
> index e392f6036f39..132596fd0860 100644
> --- a/arch/arm/boot/dts/armada-380.dtsi
> +++ b/arch/arm/boot/dts/armada-380.dtsi
> @@ -71,7 +71,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			compatible = "marvell,armada-370-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -104,6 +104,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <0>;
> @@ -122,6 +123,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <1>;
> @@ -140,6 +142,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <2>;
> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
> index db5b9f6b615d..25d2d720dc0e 100644
> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
> @@ -209,7 +209,7 @@
>  			status = "okay";
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  
>  			/*
> diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
> index df47bf1ea5eb..39f62d5ef528 100644
> --- a/arch/arm/boot/dts/armada-385-linksys.dtsi
> +++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
> @@ -241,7 +241,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  
>  			pcie at 1,0 {
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index 28eede180e4f..5511c84849ee 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -96,7 +96,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  
>  			pcie at 1,0 {
> diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
> index 8e63be33472e..534bde3fc579 100644
> --- a/arch/arm/boot/dts/armada-385.dtsi
> +++ b/arch/arm/boot/dts/armada-385.dtsi
> @@ -76,7 +76,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			compatible = "marvell,armada-370-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -115,6 +115,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <0>;
> @@ -133,6 +134,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <1>;
> @@ -151,6 +153,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <2>;
> @@ -172,6 +175,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
>  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <3>;
> diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
> index 2745b7416313..df981c34aff6 100644
> --- a/arch/arm/boot/dts/armada-388-clearfog.dts
> +++ b/arch/arm/boot/dts/armada-388-clearfog.dts
> @@ -62,7 +62,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			pcie at 3,0 {
>  				/* Port 2, Lane 0. CON2, nearest CPU. */
>  				reset-gpios = <&expander0 2 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> index 0f5938bede53..68acfc968706 100644
> --- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
> +++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> @@ -104,7 +104,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  			/*
>  			 * The two PCIe units are accessible through
> diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
> index 1ac923826445..a4ec1fa37529 100644
> --- a/arch/arm/boot/dts/armada-388-db.dts
> +++ b/arch/arm/boot/dts/armada-388-db.dts
> @@ -172,7 +172,7 @@
>  			status = "okay";
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  			/*
>  			 * The two PCIe units are accessible through
> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
> index 895fa6cfa15a..f2eb5464af1f 100644
> --- a/arch/arm/boot/dts/armada-388-gp.dts
> +++ b/arch/arm/boot/dts/armada-388-gp.dts
> @@ -240,7 +240,7 @@
>  			status = "okay";
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  			/*
>  			 * One PCIe units is accessible through
> diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
> index af82f275eac2..9cc3ca0376b9 100644
> --- a/arch/arm/boot/dts/armada-388-rd.dts
> +++ b/arch/arm/boot/dts/armada-388-rd.dts
> @@ -117,7 +117,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  			/*
>  			 * One PCIe units is accessible through
> diff --git a/arch/arm/boot/dts/armada-390-db.dts b/arch/arm/boot/dts/armada-390-db.dts
> index 2afed2ce4741..c718a5242595 100644
> --- a/arch/arm/boot/dts/armada-390-db.dts
> +++ b/arch/arm/boot/dts/armada-390-db.dts
> @@ -123,7 +123,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  
>  			/* CON30 */
> diff --git a/arch/arm/boot/dts/armada-395-gp.dts b/arch/arm/boot/dts/armada-395-gp.dts
> index 2cdbba804c1e..ef491b524fd6 100644
> --- a/arch/arm/boot/dts/armada-395-gp.dts
> +++ b/arch/arm/boot/dts/armada-395-gp.dts
> @@ -139,7 +139,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  
>  			/*
> diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
> index e8604281c3c9..f0e0379f7619 100644
> --- a/arch/arm/boot/dts/armada-398-db.dts
> +++ b/arch/arm/boot/dts/armada-398-db.dts
> @@ -118,7 +118,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			status = "okay";
>  
>  			pcie at 1,0 {
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
> index 60fbfd5907c7..ea657071e278 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -442,7 +442,7 @@
>  			};
>  		};
>  
> -		pcie-controller {
> +		pcie {
>  			compatible = "marvell,armada-370-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -481,6 +481,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <0>;
> @@ -499,6 +500,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <1>;
> @@ -517,6 +519,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <2>;
> @@ -538,6 +541,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
>  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>  				marvell,pcie-port = <3>;
> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> index f6a03dcee5ef..d79c66cd7ce5 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> @@ -81,7 +81,7 @@
>  		/*
>  		 * 98DX3236 has 1 x1 PCIe unit Gen2.0
>  		 */
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,armada-xp-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -107,6 +107,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 58>;
>  				marvell,pcie-port = <0>;
> diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
> index a33974254d8c..065282c21789 100644
> --- a/arch/arm/boot/dts/armada-xp-db.dts
> +++ b/arch/arm/boot/dts/armada-xp-db.dts
> @@ -242,7 +242,7 @@
>  		/* Port 2, Lane 0 */
>  		status = "okay";
>  	};
> -	pcie at 10,0 {
> +	pcie at a,0 {
>  		/* Port 3, Lane 0 */
>  		status = "okay";
>  	};
> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
> index d62bf7bea1df..ac9eab8ac186 100644
> --- a/arch/arm/boot/dts/armada-xp-gp.dts
> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
> @@ -227,7 +227,7 @@
>  		/* Port 2, Lane 0 */
>  		status = "okay";
>  	};
> -	pcie at 10,0 {
> +	pcie at a,0 {
>  		/* Port 3, Lane 0 */
>  		status = "okay";
>  	};
> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> index 07c5090ecd29..9fef63d02b0a 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> @@ -86,7 +86,7 @@
>  		 * configured as x4 or quad x1 lanes. One unit is
>  		 * x1 only.
>  		 */
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,armada-xp-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -123,6 +123,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 58>;
>  				marvell,pcie-port = <0>;
> @@ -140,6 +141,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 59>;
>  				marvell,pcie-port = <0>;
> @@ -157,6 +159,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 60>;
>  				marvell,pcie-port = <0>;
> @@ -174,6 +177,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
>  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 61>;
>  				marvell,pcie-port = <0>;
> @@ -191,6 +195,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
>  					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 62>;
>  				marvell,pcie-port = <1>;
> diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> index 64e936ae7b22..c753ebd86d23 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> @@ -87,7 +87,7 @@
>  		 * configured as x4 or quad x1 lanes. One unit is
>  		 * x4 only.
>  		 */
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,armada-xp-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -138,6 +138,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 58>;
>  				marvell,pcie-port = <0>;
> @@ -155,6 +156,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 59>;
>  				marvell,pcie-port = <0>;
> @@ -172,6 +174,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 60>;
>  				marvell,pcie-port = <0>;
> @@ -189,6 +192,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
>  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 61>;
>  				marvell,pcie-port = <0>;
> @@ -206,6 +210,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
>  					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 62>;
>  				marvell,pcie-port = <1>;
> @@ -223,6 +228,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x6 0 1 0
>  					  0x81000000 0 0 0x81000000 0x6 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 63>;
>  				marvell,pcie-port = <1>;
> @@ -240,6 +246,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x7 0 1 0
>  					  0x81000000 0 0 0x81000000 0x7 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 64>;
>  				marvell,pcie-port = <1>;
> @@ -257,6 +264,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x8 0 1 0
>  					  0x81000000 0 0 0x81000000 0x8 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 65>;
>  				marvell,pcie-port = <1>;
> @@ -274,6 +282,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
>  					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 99>;
>  				marvell,pcie-port = <2>;
> diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> index d1383dde43eb..d294f27540ec 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> @@ -104,7 +104,7 @@
>  		 * configured as x4 or quad x1 lanes. Two units are
>  		 * x4/x1.
>  		 */
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,armada-xp-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -159,6 +159,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 58>;
>  				marvell,pcie-port = <0>;
> @@ -176,6 +177,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 59>;
>  				marvell,pcie-port = <0>;
> @@ -193,6 +195,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 60>;
>  				marvell,pcie-port = <0>;
> @@ -210,6 +213,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
>  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 61>;
>  				marvell,pcie-port = <0>;
> @@ -227,6 +231,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
>  					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 62>;
>  				marvell,pcie-port = <1>;
> @@ -244,6 +249,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x6 0 1 0
>  					  0x81000000 0 0 0x81000000 0x6 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 63>;
>  				marvell,pcie-port = <1>;
> @@ -261,6 +267,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x7 0 1 0
>  					  0x81000000 0 0 0x81000000 0x7 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 64>;
>  				marvell,pcie-port = <1>;
> @@ -278,6 +285,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x8 0 1 0
>  					  0x81000000 0 0 0x81000000 0x8 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 65>;
>  				marvell,pcie-port = <1>;
> @@ -295,6 +303,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
>  					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 99>;
>  				marvell,pcie-port = <2>;
> @@ -303,7 +312,7 @@
>  				status = "disabled";
>  			};
>  
> -			pcie10: pcie at 10,0 {
> +			pcie10: pcie at a,0 {
>  				device_type = "pci";
>  				assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
>  				reg = <0x5000 0 0 0 0>;
> @@ -312,6 +321,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0xa 0 1 0
>  					  0x81000000 0 0 0x81000000 0xa 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &mpic 103>;
>  				marvell,pcie-port = <3>;
> diff --git a/arch/arm/boot/dts/dove-d3plug.dts b/arch/arm/boot/dts/dove-d3plug.dts
> index f5f59bb5a534..e88ff83f1dec 100644
> --- a/arch/arm/boot/dts/dove-d3plug.dts
> +++ b/arch/arm/boot/dts/dove-d3plug.dts
> @@ -88,7 +88,7 @@
>  &pcie {
>  	status = "okay";
>  	/* Fresco Logic USB3.0 xHCI controller */
> -	pcie-port at 0 {
> +	pcie at 1 {
>  		status = "okay";
>  		reset-gpios = <&gpio0 26 1>;
>  		reset-delay-us = <20000>;
> @@ -96,7 +96,7 @@
>  		pinctrl-names = "default";
>  	};
>  	/* Mini-PCIe slot */
> -	pcie-port at 1 {
> +	pcie at 2 {
>  		status = "okay";
>  		reset-gpios = <&gpio0 25 1>;
>  	};
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 698d58cea20d..1475d3672e56 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -89,7 +89,7 @@
>  			  MBUS_ID(0x03, 0x01) 0 0xc8000000 0x0100000   /* CESA SRAM  1M */
>  			  MBUS_ID(0x0d, 0x00) 0 0xf0000000 0x0100000>; /* PMU  SRAM  1M */
>  
> -		pcie: pcie-controller {
> +		pcie: pcie {
>  			compatible = "marvell,dove-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -106,7 +106,7 @@
>  				  0x82000000 0x2 0x0 MBUS_ID(0x08, 0xe8) 0 1 0   /* Port 1.0 Mem */
>  				  0x81000000 0x2 0x0 MBUS_ID(0x08, 0xe0) 0 1 0>; /* Port 1.0 I/O */
>  
> -			pcie0: pcie-port at 0 {
> +			pcie0: pcie at 1 {
>  				device_type = "pci";
>  				status = "disabled";
>  				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
> @@ -118,13 +118,14 @@
>  				#size-cells = <2>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  				          0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  
>  				#interrupt-cells = <1>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &intc 16>;
>  			};
>  
> -			pcie1: pcie-port at 1 {
> +			pcie1: pcie at 2 {
>  				device_type = "pci";
>  				status = "disabled";
>  				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
> @@ -136,6 +137,7 @@
>  				#size-cells = <2>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  				          0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  
>  				#interrupt-cells = <1>;
>  				interrupt-map-mask = <0 0 0 0>;
> diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
> index d573e03f3134..f003f3f1bd65 100644
> --- a/arch/arm/boot/dts/kirkwood-6192.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
> @@ -1,6 +1,6 @@
>  / {
>  	mbus at f1000000 {
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,kirkwood-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -24,6 +24,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &intc 9>;
>  				marvell,pcie-port = <0>;
> diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
> index 748d0b62f233..47d4b3d3d9e9 100644
> --- a/arch/arm/boot/dts/kirkwood-6281.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
> @@ -1,6 +1,6 @@
>  / {
>  	mbus at f1000000 {
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,kirkwood-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -24,6 +24,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &intc 9>;
>  				marvell,pcie-port = <0>;
> diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
> index bb63d2d50fc5..a13dad0a7c08 100644
> --- a/arch/arm/boot/dts/kirkwood-6282.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
> @@ -1,6 +1,6 @@
>  / {
>  	mbus at f1000000 {
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,kirkwood-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -28,6 +28,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &intc 9>;
>  				marvell,pcie-port = <0>;
> @@ -45,6 +46,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &intc 10>;
>  				marvell,pcie-port = <1>;
> diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
> index 720c210d491d..90d4d71b6683 100644
> --- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
> @@ -1,6 +1,6 @@
>  / {
>  	mbus at f1000000 {
> -		pciec: pcie-controller at 82000000 {
> +		pciec: pcie at 82000000 {
>  			compatible = "marvell,kirkwood-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> @@ -24,6 +24,7 @@
>  				#interrupt-cells = <1>;
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
>  				interrupt-map-mask = <0 0 0 0>;
>  				interrupt-map = <0 0 0 0 &intc 9>;
>  				marvell,pcie-port = <0>;
> -- 
> 2.10.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
