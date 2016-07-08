From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jul 2016 13:25:40 +0200
Subject: Permissions for GPIOs [Was: [PATCH] gpio: document how to order
 GPIO controllers]
In-Reply-To: <1467814334.2472.154.camel@pengutronix.de>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160705140546.GA10601@rob-hp-laptop> <20160705180447.GP16643@pengutronix.de>
 <CACRpkdbH+KRXbxFdfyAE44fBNctK4cWV+KRLwQBTzSGLvLMEDg@mail.gmail.com>
 <20160706102750.GH23470@localhost>
 <CACRpkdZhx3yTbtuj-ZTP+mtUSr4uxL4bHtu8jVZOoxrUy6=iYw@mail.gmail.com>
 <1467814334.2472.154.camel@pengutronix.de>
Message-ID: <CACRpkdbr1kpaEq-CAcv0HL5w7QC2KSBuuJ+bUWbX2ZVRknZZWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2016 at 4:12 PM, Jan L?bbe <jlu@pengutronix.de> wrote:

> This discussion caused me remember a concern regarding the chardev
> interface: Is it still be possible to give specific users/groups access
> to individual GPIOs? This is currently possible in the sysfs interface
> with chown/chmod. I don't see how per-GPIO permissions would translate
> to a per-gpiochip device.

It is not possible because it is a different model. The /dev/gpiochipN
is similar to /dev/sda for example, either you access the whole device
file not parts of it.

I think the old sysfs wrongly gives people the impression that this is
needed just because it happens to have one value per file, I can't think
of a usecase for it.

It's a bit like if we had a sysfs or similar that could give you write
permissions to just certain blocks of a disk or something using chmod.
I don't see anyone needing that other than in theory.

> Am I overlooking some better way to give non-root users granular access
> to GPIOs? Or is that intentionally out of scope for the chardev
> interface?

Intentionally out of scope I don't know, nobody raised it during review,
and I have never seen a real-world usecase.

Are there any distributions out there that ship with something like udev
files that actually go to the trouble of setting up different permissions
on GPIO sysfs files, or are we talking about hacks in a lab or even
just theoretical issues?

Yours,
Linus Walleij
