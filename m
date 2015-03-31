From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 30 Mar 2015 17:31:52 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.1 #3
In-Reply-To: <1427235082-27415-1-git-send-email-f.fainelli@gmail.com>
References: <1427235082-27415-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150331003152.GF32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 03:11:22PM -0700, Florian Fainelli wrote:
> The following changes since commit cd590b50a9367b52520f6866b27f72317bb1a07e:
> 
>   ARM: dts: enable PCIe support for Cygnus (2015-03-13 09:20:47 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/broadcom/stblinux tags/arm-soc/for-4.1/devicetree-part-3
> 
> for you to fetch changes up to 0c02acec74b655fe44b698d293f6f2a9600c4a8b:
> 
>   ARM: dts: brcmstb: add IRQ0 controller (2015-03-19 09:34:14 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains changes to the BCM7445 reference DTS files from
> Brian:
> 
> - making a clock-frequency property decimal instead of hexadecimal
> 
> - adding the irq0 interrupt controller node to make the reference DTS bootable
>   again
> 
> ----------------------------------------------------------------
> Brian Norris (2):
>       ARM: dts: brcmstb: un-hexify clock frequency
>       ARM: dts: brcmstb: add IRQ0 controller
> 
>  arch/arm/boot/dts/bcm7445.dtsi | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

FWIW, I noticed a small typo in the DTSI. I can send an official patch,
or someone could queue it up on top:

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 9eaeac8dce1b..39ac7840d7ee 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -97,7 +97,7 @@
 			reg = <0x452000 0x100>;
 		};
 
-		irq0_intc: interrupt-controller at f040a780 {
+		irq0_intc: interrupt-controller at 40a780 {
 			compatible = "brcm,bcm7120-l2-intc";
 			interrupt-parent = <&gic>;
 			#interrupt-cells = <1>;
