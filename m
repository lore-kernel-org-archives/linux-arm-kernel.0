From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Feb 2013 08:27:43 +0100
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin
 function name
In-Reply-To: <20130222055203.GB27371@S2101-09.ap.freescale.net>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
 <20130222055203.GB27371@S2101-09.ap.freescale.net>
Message-ID: <20130222072743.GC1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 01:52:04PM +0800, Shawn Guo wrote:
> On Thu, Feb 21, 2013 at 11:36:36AM -0600, Matt Sealey wrote:
> > On Wed, Feb 20, 2013 at 11:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > On Wed, Feb 20, 2013 at 06:03:39PM -0600, Matt Sealey wrote:
> > >> I am not sure I am getting this point across, but.. damn it.. nack nack nack :D
> > >>
> > > Do you see any downgrade side that the series introduces over the
> > > existing implementation?
> > 
> > Because it replaces the horribly stupid existing implementation with
> > something that doesn't solve the fundamental logical problems caused
> > by the existing implementation.
> 
> When did I say that the series is targeting to solve those "fundamental
> logical problems" in *your* view?
> 
> ...
> 
> > What you've fixed it to do, as I read this patch, is this;
> > 
> > <arbitrary_pin_name pad_mode>
> > 
> No, it's not arbitrary_pin_name.  It's pin function name which comes
> from hardware manual.  It may not exactly match the public reference
> manual, but they are obvious to be identified.  For imx6q pad SD2_DAT1
> example, the manual says:
> 
> Select 1 of 6 iomux modes to be used for pad: SD2_DAT1.
>   000 ALT0 ? Select signal SD2_DATA1.
>   001 ALT1 ? Select signal ECSPI5_SS0.
>   010 ALT2 ? Select signal EIM_CS2.
>   011 ALT3 ? Select signal AUD4_TXFS.
>   100 ALT4 ? Select signal KEY_COL7.
>   101 ALT5 ? Select signal GPIO1_IO14.

What makes them arbitrary is the fact that 110 and 111 are not encoded,
so there is no way to calculate the register number from the pin number.

Also

commit 4a5f7eff8b0b34354e5c63272835e5e2dfe1c933
Author: Dong Aisheng <dong.aisheng@linaro.org>
Date:   Fri Jul 6 17:09:23 2012 +0800

    pinctrl: pinctrl-imx6q: add missed mux function for USBOTG_ID

Shows that they are indeed arbitrary.

I'm really with Matt here when he says that this number doesn't have to
be in the binding.

What we make from this is another story. Changing this will be painful.
It will get even more painful though when the bindings are more
established in the future.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
