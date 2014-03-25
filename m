From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 25 Mar 2014 14:14:07 +0100
Subject: [PATCH 4/5] ARM: dts: tx53: add simple-panel support
In-Reply-To: <20140322064653.GC5938@dragon>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
 <1395235721-13847-4-git-send-email-LW@KARO-electronics.de>
 <20140322064653.GC5938@dragon>
Message-ID: <20140325141407.75b0750e@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> On Wed, Mar 19, 2014 at 02:28:40PM +0100, Lothar Wa?mann wrote:
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  arch/arm/boot/dts/imx53-tx53-x13x.dts |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> > index 26b918e..86a964d 100644
> > --- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
> > +++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> > @@ -63,6 +63,18 @@
> >  		default-brightness-level = <50>;
> >  	};
> >  
> > +	panel0 {
> > +		compatible = "simple-panel";
> 
> From what I can see, "simple-panel" is not a documented compatible.
> 
There is Documentation/devicetree/bindings/panel/simple-panel.txt
which describes the bindings for drivers/gpu/drm/panel/panel-simple.c.
"simple-panel" is the common compatible for all panels that the driver
supports. If no compatible for a specific panel is given, the
driver supports a generic panel with an ENABLE GPIO, an attached
backlight and a regulator. This is what's being used here. 


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
