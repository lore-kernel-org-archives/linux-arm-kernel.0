From: walimisdev@gmail.com (walimis)
Date: Fri, 4 May 2012 10:41:23 +0800
Subject: [PATCH 1/2] SPEAr: Add SMI NOR partition info in dts files
In-Reply-To: <bd96eb0df2e50de1293a8df60d30ceea920fe2b0.1336041348.git.viresh.kumar@st.com>
References: <bd96eb0df2e50de1293a8df60d30ceea920fe2b0.1336041348.git.viresh.kumar@st.com>
Message-ID: <20120504024123.GB26478@walimis-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 04:07:09PM +0530, Viresh Kumar wrote:
>This patch adds NOR partitions in all SPEAr boards dts files.
>
>Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>---
>Arnd,
>
>I will have it in my pull request for SPEAr13xx. These mails are only for
>review.
>
> arch/arm/boot/dts/spear1310-evb.dts |   25 +++++++++++++++++++++++++
> arch/arm/boot/dts/spear1340-evb.dts |   25 +++++++++++++++++++++++++
> arch/arm/boot/dts/spear300-evb.dts  |   25 +++++++++++++++++++++++++
> arch/arm/boot/dts/spear310-evb.dts  |   20 ++++++++++++++++++--
> arch/arm/boot/dts/spear320-evb.dts  |   25 +++++++++++++++++++++++++
> arch/arm/boot/dts/spear600-evb.dts  |   29 +++++++++++++++++++++++++++++
> 6 files changed, 147 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
>index 12cce81..c090833 100644
>--- a/arch/arm/boot/dts/spear1310-evb.dts
>+++ b/arch/arm/boot/dts/spear1310-evb.dts
>@@ -121,6 +121,31 @@
> 
> 		smi: flash at ea000000 {
> 			status = "okay";
>+			clock-rate=<50000000>;
>+
>+			flash at e6000000 {
>+				#address-cells = <1>;
>+				#size-cells = <1>;
>+				reg = <0xe6000000 0x800000>;
>+				st,smi-fast-mode;
>+
>+				partition at 0 {
>+					label = "xloader";
>+					reg = <0x0 0x10000>;
>+				};
>+				partition at 10000 {
>+					label = "u-boot";
>+					reg = <0x10000 0x40000>;
>+				};
>+				partition at 50000 {
>+					label = "linux";
>+					reg = <0x50000 0x2c0000>;
>+				};
>+				partition at 310000 {
>+					label = "rootfs";
>+					reg = <0x310000 0x230000>;
hi,

I have one question: we know smi nor flash has 8M Bytes, why we leave 
0x2c0000 Bytes unused?

Liming Wang
>+				};
>+			};
> 		};
> 
> 		spi0: spi at e0100000 {
>diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
>index e52b23f..0bf9d8f 100644
>--- a/arch/arm/boot/dts/spear1340-evb.dts
>+++ b/arch/arm/boot/dts/spear1340-evb.dts
>@@ -133,6 +133,31 @@
> 
> 		smi: flash at ea000000 {
> 			status = "okay";
>+			clock-rate=<50000000>;
>+
>+			flash at e6000000 {
>+				#address-cells = <1>;
>+				#size-cells = <1>;
>+				reg = <0xe6000000 0x800000>;
>+				st,smi-fast-mode;
>+
>+				partition at 0 {
>+					label = "xloader";
>+					reg = <0x0 0x10000>;
>+				};
>+				partition at 10000 {
>+					label = "u-boot";
>+					reg = <0x10000 0x40000>;
>+				};
>+				partition at 50000 {
>+					label = "linux";
>+					reg = <0x50000 0x2c0000>;
>+				};
>+				partition at 310000 {
>+					label = "rootfs";
>+					reg = <0x310000 0x230000>;
>+				};
>+			};
> 		};
> 
> 		spi0: spi at e0100000 {
>diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
>index 910e264..cb66ba2 100644
>--- a/arch/arm/boot/dts/spear300-evb.dts
>+++ b/arch/arm/boot/dts/spear300-evb.dts
>@@ -87,6 +87,31 @@
> 
> 		smi: flash at fc000000 {
> 			status = "okay";
>+			clock-rate=<50000000>;
>+
>+			flash at f8000000 {
>+				#address-cells = <1>;
>+				#size-cells = <1>;
>+				reg = <0xf8000000 0x800000>;
>+				st,smi-fast-mode;
>+
>+				partition at 0 {
>+					label = "xloader";
>+					reg = <0x0 0x10000>;
>+				};
>+				partition at 10000 {
>+					label = "u-boot";
>+					reg = <0x10000 0x40000>;
>+				};
>+				partition at 50000 {
>+					label = "linux";
>+					reg = <0x50000 0x2c0000>;
>+				};
>+				partition at 310000 {
>+					label = "rootfs";
>+					reg = <0x310000 0x230000>;
>+				};
>+			};
> 		};
> 
> 		spi0: spi at d0100000 {
>diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
>index eb9f19e..12ac5ed 100644
>--- a/arch/arm/boot/dts/spear310-evb.dts
>+++ b/arch/arm/boot/dts/spear310-evb.dts
>@@ -103,11 +103,27 @@
> 			clock-rate=<50000000>;
> 
> 			flash at f8000000 {
>-				label = "m25p64";
>-				reg = <0xf8000000 0x800000>;
> 				#address-cells = <1>;
> 				#size-cells = <1>;
>+				reg = <0xf8000000 0x800000>;
> 				st,smi-fast-mode;
>+
>+				partition at 0 {
>+					label = "xloader";
>+					reg = <0x0 0x10000>;
>+				};
>+				partition at 10000 {
>+					label = "u-boot";
>+					reg = <0x10000 0x40000>;
>+				};
>+				partition at 50000 {
>+					label = "linux";
>+					reg = <0x50000 0x2c0000>;
>+				};
>+				partition at 310000 {
>+					label = "rootfs";
>+					reg = <0x310000 0x230000>;
>+				};
> 			};
> 		};
> 
>diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
>index 96280fe..a2115aa 100644
>--- a/arch/arm/boot/dts/spear320-evb.dts
>+++ b/arch/arm/boot/dts/spear320-evb.dts
>@@ -110,6 +110,31 @@
> 
> 		smi: flash at fc000000 {
> 			status = "okay";
>+			clock-rate=<50000000>;
>+
>+			flash at f8000000 {
>+				#address-cells = <1>;
>+				#size-cells = <1>;
>+				reg = <0xf8000000 0x800000>;
>+				st,smi-fast-mode;
>+
>+				partition at 0 {
>+					label = "xloader";
>+					reg = <0x0 0x10000>;
>+				};
>+				partition at 10000 {
>+					label = "u-boot";
>+					reg = <0x10000 0x40000>;
>+				};
>+				partition at 50000 {
>+					label = "linux";
>+					reg = <0x50000 0x2c0000>;
>+				};
>+				partition at 310000 {
>+					label = "rootfs";
>+					reg = <0x310000 0x230000>;
>+				};
>+			};
> 		};
> 
> 		spi0: spi at d0100000 {
>diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
>index 790a7a8..1872cb0 100644
>--- a/arch/arm/boot/dts/spear600-evb.dts
>+++ b/arch/arm/boot/dts/spear600-evb.dts
>@@ -33,6 +33,35 @@
> 			status = "okay";
> 		};
> 
>+		smi: flash at fc000000 {
>+			status = "okay";
>+			clock-rate=<50000000>;
>+
>+			flash at f8000000 {
>+				#address-cells = <1>;
>+				#size-cells = <1>;
>+				reg = <0xf8000000 0x800000>;
>+				st,smi-fast-mode;
>+
>+				partition at 0 {
>+					label = "xloader";
>+					reg = <0x0 0x10000>;
>+				};
>+				partition at 10000 {
>+					label = "u-boot";
>+					reg = <0x10000 0x40000>;
>+				};
>+				partition at 50000 {
>+					label = "linux";
>+					reg = <0x50000 0x2c0000>;
>+				};
>+				partition at 310000 {
>+					label = "rootfs";
>+					reg = <0x310000 0x230000>;
>+				};
>+			};
>+		};
>+
> 		apb {
> 			serial at d0000000 {
> 				status = "okay";
>-- 
>1.7.9
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
