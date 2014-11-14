From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 14 Nov 2014 22:14:44 +0100
Subject: [PATCH v7 11/13] ARM: dts: Berlin: enable USB on the BG2Q DMP
In-Reply-To: <54664E2F.6070701@cogentembedded.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
 <1415978763-27345-12-git-send-email-antoine.tenart@free-electrons.com>
 <54664E2F.6070701@cogentembedded.com>
Message-ID: <20141114211444.GB8105@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 14, 2014 at 09:47:11PM +0300, Sergei Shtylyov wrote:
> On 11/14/2014 06:26 PM, Antoine Tenart wrote:
> 
> >Enable the 2 available USB PHY and USB nodes on the Marvell Berlin BG2Q
> >DMP.
> 
> >Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> >---
> >  arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 53 ++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> 
> >diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> >index ea1f99b8eed6..f7c25580e122 100644
> >--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> >+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> [...]
> >@@ -21,6 +23,39 @@
> >  	choosen {
> >  		bootargs = "console=ttyS0,115200 earlyprintk";
> >  	};
> >+
> >+	regulators {
> >+		compatible = "simple-bus";
> >+		#address-cells = <1>;
> >+		#size-cells = <0>;
> >+
> >+		reg_usb0_vbus: regulator at 0 {
> 
>    Erm, I'm not seeing the "reg" prop. The <unit-address> part of the name
> shouldn't be used without the "reg" prop.
> 
> [...]

Well, I respect the bindings described at:
Documentation/devicetree/bindings/regulator/fixed-regulator.txt

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
