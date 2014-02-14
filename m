From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 14 Feb 2014 15:02:08 +0100
Subject: How to select between different display timings? (was: [PATCH
 7/8] ARM: dts: tx28: restructure and update DTS file)
In-Reply-To: <52FE1F2D.4010102@de.bosch.com>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
 <1375966287-6784-8-git-send-email-LW@KARO-electronics.de>
 <52FE1F2D.4010102@de.bosch.com>
Message-ID: <20140214150208.12417b11@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dirk Behme wrote:
> Hi Lothar and Shawn,
> 
> On 08.08.2013 14:51, Lothar Wa?mann wrote:
> > - add Copyright header
> > - use label references for better readability
> > - sort the entries alphabetically
> > - add some aliases used by U-Boot to edit the DT data
> >
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >   arch/arm/boot/dts/imx28-tx28.dts |  693 +++++++++++++++++++++++++++++++++-----
> >   1 files changed, 611 insertions(+), 82 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> > index 37be532..866af60 100644
> > --- a/arch/arm/boot/dts/imx28-tx28.dts
> > +++ b/arch/arm/boot/dts/imx28-tx28.dts
> ...
> > +&lcdif {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&lcdif_24bit_pins_a &lcdif_sync_pins_a &lcdif_ctrl_pins_a>;
> > +       lcd-supply = <&reg_lcd>;
> > +       display = <&display>;
> > +       status = "okay";
> > +
> > +       display: display at 0 {
> > +               bits-per-pixel = <32>;
> > +               bus-width = <24>;
> > +
> > +               display-timings {
> > +                       native-mode = <&timing5>;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^
> > +                       timing0: timing0 {
[...]
> > +                       };
> > +               };
> > +       };
> > +};
> 
> Being no graphics expert, looking at above device tree change, I'd like 
> to understand how this can be used to switch between different display 
> timings?
> 
> In the kernel, I've found the code which selects the default/native-mode 
> (of_display_timing.c). But, as here, if there is a native/default mode, 
> there are alternative modes. I haven't understood how and who to select 
> these other modes? In this case, how could the alternative modes 
> timing0/1/2/3/4 be selected in the kernel?
> 
> Do you have any pointers regarding this?
> 
You need to set the property 'native-mode' to the phandle of the
display-timings entry like marked above.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
