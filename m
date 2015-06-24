From: rogerq@ti.com (Roger Quadros)
Date: Wed, 24 Jun 2015 16:50:08 +0300
Subject: [PATCH 11/17] ARM: dts: dra7: Use "ti,dra7x-usb2-phy2"
 compatible string for USB2 PHY2
In-Reply-To: <558AAC47.2070305@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-12-git-send-email-kishon@ti.com>
 <20150624150750.9435096c85253cfe528ebbc3@ti.com>
 <558AAC47.2070305@ti.com>
Message-ID: <20150624165008.36bed5c058fa4f43e7748c5c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jun 2015 18:40:31 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Hi,
> 
> On Wednesday 24 June 2015 05:37 PM, Roger Quadros wrote:
> > On Tue, 23 Jun 2015 17:28:56 +0530
> > Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > 
> >> The USB2 PHY2 has a different register map compared to USB2 PHY1
> >> to power on/off the PHY. In order to handle it, use the new compatible
> >> string "ti,dra7x-usb2-phy2" for the second instance of USB2 PHY.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  arch/arm/boot/dts/dra7.dtsi |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> >> index f69db70..a8ee829 100644
> >> --- a/arch/arm/boot/dts/dra7.dtsi
> >> +++ b/arch/arm/boot/dts/dra7.dtsi
> >> @@ -1235,7 +1235,7 @@
> >>  			};
> >>  
> >>  			usb2_phy2: phy at 4a085000 {
> >> -				compatible = "ti,omap-usb2";
> >> +				compatible = "ti,dra7x-usb2-phy2", "ti,omap-usb2";
> > 
> > Why do you want to retain "ti,omap-usb2".
> > It is not backward compatible with it right?
> 
> The newer dtbs will anyway have "ti,dra7x-usb2-phy2", so "ti,omap-usb2" was
> kept just for legacy reasons.

OK then.

cheers,
-roger
