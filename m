From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 24 Mar 2014 13:47:32 +0100
Subject: [PATCH 5/5] ARM: dts: tx53: Add IPU DI ports and endpoints
In-Reply-To: <20140322065038.GE5938@dragon>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
 <1395235721-13847-5-git-send-email-LW@KARO-electronics.de>
 <20140322065038.GE5938@dragon>
Message-ID: <20140324134732.43e59627@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> On Wed, Mar 19, 2014 at 02:28:41PM +0100, Lothar Wa?mann wrote:
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  arch/arm/boot/dts/imx53-tx53-x03x.dts |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> > index 0217dde3..43b4b7b 100644
> > --- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
> > +++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
> > @@ -25,12 +25,17 @@
> >  	soc {
> >  		display: display at di0 {
> >  			compatible = "fsl,imx-parallel-display";
> > -			crtcs = <&ipu 0>;
> >  			interface-pix-fmt = "rgb24";
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&pinctrl_rgb24_vga1>;
> >  			status = "okay";
> >  
> > +			port {
> > +				display0_in: endpoint {
> > +					remote-endpoint = <&ipu_di0_disp0>;
> > +				};
> > +			};
> > +
> 
> I shouldn't apply this until I rebase my branch on 3.15-rc1 where
> Philipp's OF graph is to be seen, right?
> 
That's ok with me.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
