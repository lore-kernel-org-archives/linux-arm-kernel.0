From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jul 2016 16:34:58 +0200
Subject: [PATCH] gpio: document how to order GPIO controllers
In-Reply-To: <20160713131412.GO6442@localhost>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160705140546.GA10601@rob-hp-laptop> <20160705180447.GP16643@pengutronix.de>
 <CACRpkdbH+KRXbxFdfyAE44fBNctK4cWV+KRLwQBTzSGLvLMEDg@mail.gmail.com>
 <20160706102750.GH23470@localhost>
 <CACRpkdZhx3yTbtuj-ZTP+mtUSr4uxL4bHtu8jVZOoxrUy6=iYw@mail.gmail.com>
 <20160713131412.GO6442@localhost>
Message-ID: <CACRpkdYMrfRmmY=ABPj2zoA-kW0gkPRwzeC=U3XhKs1PGRe4vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 3:14 PM, Johan Hovold <johan@kernel.org> wrote:
> On Wed, Jul 06, 2016 at 02:34:39PM +0200, Linus Walleij wrote:

>> For the purpose of picking a certain named GPIO line (see below)
>> knowing this number is unnecessary. To that mechanism all gpio
>> chips are equal and the instance number does not matter.
>
> My point was that with gpio line names (and possibly topological
> information to resolve duplicates), the N number should not matter
> anymore.

Agreed. It doesn't, with the new ABI. Not for technical reasons, at all.

> If one needs to look up a particular gpiochip based on some hardware
> naming convention, why not associate a name with the chip instead of
> trying to shoehorn the dynamic gpiochip range in there?

With the new ABI it is possible to set a "label" for the gpiochip, currently
described as "a functional name for this GPIO chip, such as a product
number" and it's certainly possible to manage this name carefully for
a system to look up a certain chip.

[About obtaining topological  information from sysfs]
> And this may even be unavoidable with dynamic buses such as USB or
> greybus, where you can have multiple devices associating the same name
> with a pin. That's fine as long as the user-space interface allows for a
> way to distinguish them (e.g. through topological information).

This should work fine AFAICT. All the ABI and information is in place
to deal with this.

Yours,
Linus Walleij
