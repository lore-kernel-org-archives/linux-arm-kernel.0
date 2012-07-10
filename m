From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 23:23:53 +0800
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207100920.03867.marex@denx.de>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <1341898587-8462-4-git-send-email-shawn.guo@linaro.org>
 <201207100920.03867.marex@denx.de>
Message-ID: <20120710152350.GA11813@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 09:20:03AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > From: Marek Vasut <marex@denx.de>
> > 
> [...]
> 
> > +	sound {
> > +		compatible = "fsl,imx28-evk-sgtl5000",
> 
> imx28-evk ? ;-)
> 
Fixed as below.

Regards,
Shawn

---8<---

diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
index a670a90..04664bc 100644
--- a/arch/arm/boot/dts/apx4devkit.dts
+++ b/arch/arm/boot/dts/apx4devkit.dts
@@ -124,9 +124,9 @@
        };

        sound {
-               compatible = "fsl,imx28-evk-sgtl5000",
+               compatible = "bluegiga,apx4devkit-sgtl5000",
                             "fsl,mxs-audio-sgtl5000";
-               model = "imx28-evk-sgtl5000";
+               model = "apx4devkit-sgtl5000";
                saif-controllers = <&saif0 &saif1>;
                audio-codec = <&sgtl5000>;
        };
diff --git a/arch/arm/boot/dts/m28evk.dts b/arch/arm/boot/dts/m28evk.dts
index f3acdfa..183a3fd 100644
--- a/arch/arm/boot/dts/m28evk.dts
+++ b/arch/arm/boot/dts/m28evk.dts
@@ -201,9 +201,9 @@
        };

        sound {
-               compatible = "fsl,imx28-evk-sgtl5000",
+               compatible = "denx,m28evk-sgtl5000",
                             "fsl,mxs-audio-sgtl5000";
-               model = "imx28-evk-sgtl5000";
+               model = "m28evk-sgtl5000";
                saif-controllers = <&saif0 &saif1>;
                audio-codec = <&sgtl5000>;
        };
