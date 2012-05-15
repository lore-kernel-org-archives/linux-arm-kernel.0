From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 15 May 2012 20:31:38 +0800
Subject: [PATCH 1/2] ARM: dts: add device tree source for imx6dl
In-Reply-To: <1337084027-19401-1-git-send-email-shawn.guo@linaro.org>
References: <1337084027-19401-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120515123137.GI20367@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 08:13:47PM +0800, Shawn Guo wrote:
> The imx6dl (i.MX6 DualLite) is a derivative of SoC imx6q, and it's
> highly compatible with imx6q.  This patch renames imx6q.dtsi to
> imx6.dtsi with some cosmetic changes, and split out the differences
> between imx6dl and imx6q into imx6dl.dtsi and imx6q.dtsi respectively.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx6.dtsi   |  691 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6dl.dtsi |   62 ++++
>  arch/arm/boot/dts/imx6q.dtsi  |  677 +---------------------------------------
>  3 files changed, 757 insertions(+), 673 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6dl.dtsi
> 
The follow changes should be amened.  Sorry for these errors.

diff --git a/arch/arm/boot/dts/imx6.dtsi b/arch/arm/boot/dts/imx6.dtsi
index 72e5434..c60864f 100644
--- a/arch/arm/boot/dts/imx6.dtsi
+++ b/arch/arm/boot/dts/imx6.dtsi
@@ -501,7 +501,6 @@
                                        };
                                };
                        };
-                       };

                        dcic1: dcic at 020e4000 {
                                reg = <0x020e4000 0x4000>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index b154232..0300189 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -43,7 +43,7 @@
        };

        soc {
-               aips2: aips-bus at 02100000 {
+               aips1: aips-bus at 02000000 {
                        spba-bus at 02000000 {
                                ecspi5: ecspi at 02018000 {
                                        #address-cells = <1>;
