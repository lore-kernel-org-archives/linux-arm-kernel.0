From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 9 Jan 2013 01:04:53 +0000
Subject: [v3 PATCH 9/9] ARM: dts: add the watchdog nodes for
 at91sam9g25ek boards
In-Reply-To: <20130108200149.GE7360@game.jcrosoft.org>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
 <1357353529-20901-10-git-send-email-wenyou.yang@atmel.com>
 <20130108200149.GE7360@game.jcrosoft.org>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A058680@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> Sent: 2013?1?9? 4:02
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; Ferre, Nicolas; Lin, JM;
> linux at arm.linux.org.uk; linux-kernel at vger.kernel.org
> Subject: Re: [v3 PATCH 9/9] ARM: dts: add the watchdog nodes for
> at91sam9g25ek boards
> 
> On 10:38 Sat 05 Jan     , Wenyou Yang wrote:
> > Tested on the at91sam9g25ek boards
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: linux at arm.linux.org.uk
> > Cc: linux-kernel at vger.kernel.org
> > ---
> >  arch/arm/boot/dts/at91sam9x5ek.dtsi |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> > index 8a7cf1d..afddf75 100644
> > --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> > @@ -69,6 +69,10 @@
> >  				status = "okay";
> >  			};
> >
> > +			watchdog at fffffe40 {
> > +				status = "okay";
> > +			};
> > +
> 
> use less today as the watchdog is shutdown at bootstrap level
> 
> and on at91 once shutdown we can not enable it again

Yes, you are right.
But, If you want to use the watchdog, you should not disable the watchdog.
Also in the new version at91bootstrap, it provide this config option.

If the watchdog is disabled in the bootstrap, "the watchdog has been disabled" will display in the dmesg.

> 
> Best Regards,
> J.
> >  			pinctrl at fffff400 {
> >  				mmc0 {
> >  					pinctrl_board_mmc0: mmc0-board {
> > --
> > 1.7.9.5
> >

Best Regards,
Wenyou Yang
