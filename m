From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 17 Apr 2014 09:35:34 +0200
Subject: [PATCH 9/10] ARM: dts: tx28: restructure and update DTS file
In-Reply-To: <534F7710.8050801@de.bosch.com>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
 <1375281480-25775-9-git-send-email-LW@KARO-electronics.de>
 <534F7710.8050801@de.bosch.com>
Message-ID: <20140417093534.5a513b05@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dirk Behme wrote:
> On 31.07.2013 16:37, Lothar Wa?mann wrote:
> >
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
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
> > +                       timing0: timing0 {
> > +                               panel-name = "VGA";
> ...
> 
> I've been looking for any user or documentation of 'panel-name'. But 
> couldn't find anything. Anything I missed?
> 
Our U-Boot uses this to find the active video setting according to an
environment variable setting.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
