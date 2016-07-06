From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Wed, 06 Jul 2016 16:12:14 +0200
Subject: Permissions for GPIOs [Was: [PATCH] gpio: document how to order
 GPIO controllers]
In-Reply-To: <CACRpkdZhx3yTbtuj-ZTP+mtUSr4uxL4bHtu8jVZOoxrUy6=iYw@mail.gmail.com>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160705140546.GA10601@rob-hp-laptop>
 <20160705180447.GP16643@pengutronix.de>
 <CACRpkdbH+KRXbxFdfyAE44fBNctK4cWV+KRLwQBTzSGLvLMEDg@mail.gmail.com>
 <20160706102750.GH23470@localhost>
 <CACRpkdZhx3yTbtuj-ZTP+mtUSr4uxL4bHtu8jVZOoxrUy6=iYw@mail.gmail.com>
Message-ID: <1467814334.2472.154.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mi, 2016-07-06 at 14:34 +0200, Linus Walleij wrote:
> On Wed, Jul 6, 2016 at 12:27 PM, Johan Hovold <johan@kernel.org> wrote:
> > What's wrong with naming the pins in DT and use that for lookups?
> 
> That works. It relies on the developers using sane naming conventions
> though. (This problem is prevalent everywhere I guess, a human problem,
> not a technical one.) I made this patch:
> http://marc.info/?l=linux-arm-kernel&m=146672328215354&w=2
> 
> There is a standard document for these boards (96board) specifying
> the names of the GPIO lines to be "GPIO-A" thru "GPIO-L".
> 
> So a user can iterate across the gpiochips (as is done in lsgpio)
> and pick the lines with the right names.

This discussion caused me remember a concern regarding the chardev
interface: Is it still be possible to give specific users/groups access
to individual GPIOs? This is currently possible in the sysfs interface
with chown/chmod. I don't see how per-GPIO permissions would translate
to a per-gpiochip device.

Am I overlooking some better way to give non-root users granular access
to GPIOs? Or is that intentionally out of scope for the chardev
interface?

Yours,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
