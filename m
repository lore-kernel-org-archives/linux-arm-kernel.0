From: lukma@denx.de (Lukasz Majewski)
Date: Fri, 17 Nov 2017 16:03:47 +0100
Subject: [PATCH 1/2] ARM: dts: Add the support for display5 equipped
 with Mitsubishi (800x480) display
In-Reply-To: <1510929383.8104.3.camel@pengutronix.de>
References: <20171117102404.6678-1-lukma@denx.de>
 <20171117131047.GE25390@dragon> <20171117151334.041c4684@jawa>
 <1510929383.8104.3.camel@pengutronix.de>
Message-ID: <20171117160347.5c78be6e@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

> Am Freitag, den 17.11.2017, 15:13 +0100 schrieb Lukasz Majewski:
> > Hi Shawn,
> >   
> > > On Fri, Nov 17, 2017 at 11:24:03AM +0100, Lukasz Majewski wrote:  
> > > > This is the support for aa070mc01-ca1 Mitsubishi display.
> > > > 
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > > ?arch/arm/boot/dts/Makefile?????????????????????????|??1 +
> > > > ?.../imx6q-display5-mitsubishi-aa070-800x480.dts????| 51
> > > > ++++++++++++++++++++++ 2 files changed, 52 insertions(+)
> > > > ?create mode 100644
> > > > arch/arm/boot/dts/imx6q-display5-mitsubishi-aa070-800x480.dts
> > > > 
> > > > diff --git a/arch/arm/boot/dts/Makefile
> > > > b/arch/arm/boot/dts/Makefile
> > > > index d9d0c82e7d20..10b3ad078dea 100644
> > > > --- a/arch/arm/boot/dts/Makefile
> > > > +++ b/arch/arm/boot/dts/Makefile
> > > > @@ -407,6 +407,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
> > > > ?	imx6q-cm-fx6.dtb \
> > > > ?	imx6q-cubox-i.dtb \
> > > > ?	imx6q-dfi-fs700-m60.dtb \
> > > > +	imx6q-display5-mitsubishi-aa070-800x480.dtb \
> > > > ?	imx6q-display5-tianma-tm070-1280x768.dtb \
> > > > ?	imx6q-dmo-edmqmx6.dtb \
> > > > ?	imx6q-evi.dtb \??  
> > > 
> > > <snip>
> > >   
> > > > +#include "imx6q-display5.dtsi"
> > > > +
> > > > +&panel {
> > > > +	compatible = "mitsubishi,aa070mc01-ca1";
> > > > +};??  
> > > 
> > > How many DTB files do you want to add for this display5 board???  
> > 
> > This is a single board, which can support panels which I've posted.
> > 
> > Those dtbs I do pack to u-boot' FIT image and don't need to worry
> > that
> > some display is not working (after setting bootloader env variable).
> >   
> > > It's
> > > obvious no fun to maintain a bunch of DTB files for all the panels
> > > this board can support.  
> > 
> > Please note that those files excessively use #include directive, and
> > there is not so much code added (the longest part is license and
> > comments).
> >   
> > > ?Let's stop right here.  
> > 
> > If I may ask - how shall I proceed? What would be your suggestion to
> > move on (dtb overlays) ?  
> 
> The solution we use for the ZII RDU1 and RDU2 boards is to have the
> bootloader patch in the correct panel compatible strings. 

Do you mean adjusting the DTB accordingly in u-boot for each display -
change panel/compatible to new display name ?

> This is
> quite a bit simpler than using overlays and if you already have a
> environment variable for this it should be easy to do.
> 
> > > 
> > > Shawn
> > >   
> > > > +
> > > > +&ldb {
> > > > +	lvds0: lvds-channel at 0 {
> > > > +		fsl,data-mapping = "spwg";
> > > > +		fsl,data-width = <24>;
> > > > +	};
> > > > +};  
> 
> This isn't needed. The panel compatible implies the data mapping and
> bus width (at least if you properly filled in this information in the
> panel driver).
> 
> Regards,
> Lucas



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171117/3ce4873b/attachment.sig>
