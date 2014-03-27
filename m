From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 27 Mar 2014 23:57:52 +0100
Subject: [PATCH 1/2] leds: add DT support for LEDs wired to supply and
 default brightness
In-Reply-To: <CAK5ve-+K+R=c7Lp+JaTCOcq9LYHTszQQg9Xp1fQHxqcQ2cVHHw@mail.gmail.com>
References: <E1WJUvl-0003wc-0S@rmk-PC.arm.linux.org.uk>
 <CAK5ve-+K+R=c7Lp+JaTCOcq9LYHTszQQg9Xp1fQHxqcQ2cVHHw@mail.gmail.com>
Message-ID: <20140327225752.GD15793@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 03:28:32PM -0700, Bryan Wu wrote:
> On Fri, Feb 28, 2014 at 1:25 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Some PWM outputs are wired such that the LED they're controlling is
> > connected to supply rather than ground.  Therefore, the duty cycle
> > needs to be inverted to make the LED behave as it should do.
> >
> > We also provide a way to specify the default brightness when a
> > trigger is not specified.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  Documentation/devicetree/bindings/leds/leds-pwm.txt |  3 +++
> >  drivers/leds/leds-pwm.c                             | 15 +++++++++++----
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.txt b/Documentation/devicetree/bindings/leds/leds-pwm.txt
> > index 7297107cf832..ffcb74ab61fd 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-pwm.txt
> > +++ b/Documentation/devicetree/bindings/leds/leds-pwm.txt
> > @@ -13,6 +13,9 @@ node's name represents the name of the corresponding LED.
> >    For the pwms and pwm-names property please refer to:
> >    Documentation/devicetree/bindings/pwm/pwm.txt
> >  - max-brightness : Maximum brightness possible for the LED
> > +- default-brightness : (optional) Default brightness for the LED
> > +- active-low : (optional) For PWMs where the LED is wired to supply
> > +  rather than ground.
> >  - label :  (optional)
> >    see Documentation/devicetree/bindings/leds/common.txt
> >  - linux,default-trigger :  (optional)
> 
> Why remove "max-brightness", "label" and "linux,default-trigger" here?
They are not removed, they are just unchanged list items after literal
'-'s in the context of the patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
