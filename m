From: harald@ccbib.org (Harald Geyer)
Date: Mon, 19 Mar 2018 16:27:36 +0100
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <20180318202251.5gpv6sblfr4edxmj@flea>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <20180318202251.5gpv6sblfr4edxmj@flea>
Message-ID: <E1exwhF-0000Qw-4g@stardust.g4.wien.funkfeuer.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard writes:
> On Thu, Mar 15, 2018 at 04:25:10PM +0000, Harald Geyer wrote:
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		capslock {
> > +			label = "leds:green:capslock";
> 
> The first part is supposed to be the name of the boards. I did sed
> s/leds/teres-i/, and applied,

I'm not sure what good this convention would do, if anything it seems
to make it harder to write portable scripts, but in the end I don't care.

> together with all the patches but the
> PWM (so I had to drop the backlight node as well).
>
> Please coordinate with Andre about who should send the PWM support.

Seems the patch got broken because only the backlight node but not the
pwm node was removed. Anyway, since Andre has already sent an updated
version of his series, maybe just revert the broken patch, merge his
series and then apply the original teres-i patch again?

I'm going to test his patches soon, but I don't expect any problems.

Thanks,
Harald
