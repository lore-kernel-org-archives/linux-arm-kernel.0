From: guido@vanguardiasur.com.ar (Guido =?iso-8859-1?Q?Mart=EDnez?=)
Date: Mon, 28 Apr 2014 13:10:41 -0300
Subject: [PATCH 1/4] ARM: dts: am335x-bone-common: use phandles for USB
 and DMA refs
In-Reply-To: <535E689D.7010204@ti.com>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <535E689D.7010204@ti.com>
Message-ID: <20140428161041.GA6140@solid>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 08:11:33PM +0530, George Cherian wrote:
> On 4/28/2014 7:28 PM, Guido Mart?nez wrote:
> >Use phandles instead of unit adresses to reference usb and dma nodes.
> >This makes the DT more robust and readable.
> The series will give dtb build errors
> Error: arch/arm/boot/dts/am335x-bone-common.dtsi:186.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> Error: arch/arm/boot/dts/am335x-evmsk.dts:367.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-bone.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Error: arch/arm/boot/dts/am335x-evm.dts:334.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-evmsk.dtb] Error 1
> make[1]: *** [arch/arm/boot/dts/am335x-evm.dtb] Error 1
> Error: arch/arm/boot/dts/am335x-igep0033.dtsi:204.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-base0033.dtb] Error 1
> Error: arch/arm/boot/dts/am335x-bone-common.dtsi:186.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-boneblack.dtb] Error 1
> make: *** [dtbs] Error 2
> 
Terribly sorry about this. I'll send a v2.

> >
> >Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
> >---
> >  arch/arm/boot/dts/am335x-bone-common.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> >index 2e7d932..b95bc9a 100644
> >--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> >+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> >@@ -183,28 +183,28 @@
> >  &usb {
> >  	status = "okay";
> >-	control at 44e10620 {
> >+	&usb_ctrl_mod {
> >  		status = "okay";
> >  	};
> >-	usb-phy at 47401300 {
> >+	&usb0_phy {
> >  		status = "okay";
> >  	};
> >-	usb-phy at 47401b00 {
> >+	&usb1_phy {
> >  		status = "okay";
> >  	};
> >-	usb at 47401000 {
> >+	&usb0 {
> >  		status = "okay";
> >  	};
> >-	usb at 47401800 {
> >+	&usb1 {
> >  		status = "okay";
> >  		dr_mode = "host";
> >  	};
> >-	dma-controller at 47402000  {
> >+	&cppi41dma  {
> >  		status = "okay";
> >  	};
> >  };
> Instead the patch should be
> 
>      diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi
> b/arch/arm/boot/dts/am335x-bone-common.dtsi
>      index 2e7d932..06be20a 100644
>      --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
>      +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
>      @@ -182,31 +182,30 @@
> 
>       &usb {
>              status = "okay";
>      +};
>      +&usb_ctrl_mod {
>      +       status = "okay";
>      +};
> 
>      -       control at 44e10620 {
>      -               status = "okay";
>      -       };
>      -
>      -       usb-phy at 47401300 {
>      -               status = "okay";
>      -       };
>      +&usb0_phy {
>      +       status = "okay";
>      +};
> 
>      -       usb-phy at 47401b00 {
>      -               status = "okay";
>      -       };
>      +&usb1_phy {
>      +       status = "okay";
>      +};
> 
>      -       usb at 47401000 {
>      -               status = "okay";
>      -       };
>      +&usb {
>      +       status = "okay";
>      +};
> 
>      -       usb at 47401800 {
>      -               status = "okay";
>      -               dr_mode = "host";
>      -       };
>      +&usb1 {
>      +       status = "okay";
>      +       dr_mode = "host";
>      +};
> 
>      -       dma-controller at 47402000  {
>      -               status = "okay";
>      -       };
>      +&cppi41dma  {
>      +       status = "okay";
>       };
> 
> 
> 
> -- 
> -George
> 

-- 
Guido Mart?nez, VanguardiaSur
www.vanguardiasur.com.ar
