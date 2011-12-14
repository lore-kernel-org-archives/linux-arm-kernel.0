From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 14 Dec 2011 14:23:33 +0800
Subject: [PATCH V3 2/4] dts/imx: rename uart labels to consistent with hw
 spec
In-Reply-To: <1323826007-17937-3-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
 <1323826007-17937-3-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111214062332.GB11874@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:26:45AM +0800, Richard Zhao wrote:
> UART1/UART2/... is more readable than UART0/UART1/... .
> Remove redundant UART comments.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts   |    6 +++---
>  arch/arm/boot/dts/imx51.dtsi          |   12 ++++++------
>  arch/arm/boot/dts/imx53-ard.dts       |    2 +-
>  arch/arm/boot/dts/imx53-evk.dts       |    2 +-
>  arch/arm/boot/dts/imx53-qsb.dts       |    2 +-
>  arch/arm/boot/dts/imx53-smd.dts       |    6 +++---
>  arch/arm/boot/dts/imx53.dtsi          |   18 +++++++++---------
>  arch/arm/boot/dts/imx6q-sabreauto.dts |    2 +-
>  arch/arm/boot/dts/imx6q.dtsi          |   20 ++++++++++----------
>  9 files changed, 35 insertions(+), 35 deletions(-)

Applied, with the missing change below amended.

8<----

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c10dc1f..5dd91b9 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -88,7 +88,7 @@
                                        status = "disabled";
                                };

-                               uart2: uart at 5000c000 { /* UART3 */
+                               uart3: uart@5000c000 {
                                        compatible = "fsl,imx53-uart", "fsl,imx21-uart";
                                        reg = <0x5000c000 0x4000>;
                                        interrupts = <33>;

----->8

Otherwise, we see something like below.

  DTC     arch/arm/boot/imx53-smd.dtb
DTC: dts->dtb  on file "/home/r65073/repos/shawnguo/linux-2.6/arch/arm/boot/dts/imx53-smd.dts"
ERROR (duplicate_label): Duplicate label 'uart2' on /soc/aips at 50000000/uart at 53fc0000 and /soc/aips at 50000000/spba at 50000000/uart at 5000c000
ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/arm/boot/imx53-smd.dtb] Error 2
make[1]: *** [imx53-smd.dtb] Error 2
make: *** [sub-make] Error 2

-- 
Regards,
Shawn
