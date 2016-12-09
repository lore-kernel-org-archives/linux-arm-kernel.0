From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 09 Dec 2016 19:28:36 +0100
Subject: [PATCH 6/9] dt-bindings: Document rk3399 Gru/Kevin
In-Reply-To: <20161209175402.gy4mqjaf2rsib7qf@rob-hp-laptop>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <1480645653-36943-7-git-send-email-briannorris@chromium.org>
 <20161209175402.gy4mqjaf2rsib7qf@rob-hp-laptop>
Message-ID: <3895286.MqKyp9eiJu@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. Dezember 2016, 11:54:02 CET schrieb Rob Herring:
> On Thu, Dec 01, 2016 at 06:27:30PM -0800, Brian Norris wrote:
> > Gru is a base dev board for a family of devices, including Kevin. Both
> > utilize Rockchip RK3399, and they share much of their design.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >  Documentation/devicetree/bindings/arm/rockchip.txt | 20
> >  ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> > b/Documentation/devicetree/bindings/arm/rockchip.txt index
> > cc4ace6397ab..830e13f5890c 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> > @@ -99,6 +99,26 @@ Rockchip platforms device tree bindings
> > 
> >  		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
> >  		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
> > 
> > +- Google Gru (dev-board):
> > +    Required root node properties:
> > +      - compatible = "google,gru-rev15", "google,gru-rev14",
> > +		     "google,gru-rev13", "google,gru-rev12",
> > +		     "google,gru-rev11", "google,gru-rev10",
> > +		     "google,gru-rev9", "google,gru-rev8",
> > +		     "google,gru-rev7", "google,gru-rev6",
> > +		     "google,gru-rev5", "google,gru-rev4",
> > +		     "google,gru-rev3", "google,gru-rev2",
> > +		     "google,gru", "rockchip,rk3399";
> 
> All of these are supposed to be specified or just one rev at a time?

All of them. I.e. the devicetree is supposed to be compatible with all of 
those, while the bootloader determines the actual board revision and sets the 
choosen compatible - at least that was the way with the previous series of 
devices based around the rk3288 (veyron) and I think it will be the same way 
still.

I.e. as you can see below, Kevin starts being compatible at -rev6, as 
(engineering) revisions before that probably had some differences on the 
board.


> 
> > +
> > +- Google Kevin:
> > +    Required root node properties:
> > +      - compatible = "google,kevin-rev15", "google,kevin-rev14",
> > +		     "google,kevin-rev13", "google,kevin-rev12",
> > +		     "google,kevin-rev11", "google,kevin-rev10",
> > +		     "google,kevin-rev9", "google,kevin-rev8",
> > +		     "google,kevin-rev7", "google,kevin-rev6",
> > +		     "google,kevin", "google,gru", "rockchip,rk3399";
> > +
> > 
> >  - mqmaker MiQi:
> >      Required root node properties:
> >        - compatible = "mqmaker,miqi", "rockchip,rk3288";
