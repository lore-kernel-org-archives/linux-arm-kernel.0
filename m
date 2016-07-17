From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 17:03:09 -0500
Subject: [PATCH] gpio: document how to order GPIO controllers
In-Reply-To: <CACRpkdbH+KRXbxFdfyAE44fBNctK4cWV+KRLwQBTzSGLvLMEDg@mail.gmail.com>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160705140546.GA10601@rob-hp-laptop>
 <20160705180447.GP16643@pengutronix.de>
 <CACRpkdbH+KRXbxFdfyAE44fBNctK4cWV+KRLwQBTzSGLvLMEDg@mail.gmail.com>
Message-ID: <20160717220309.GA22711@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 11:34:37AM +0200, Linus Walleij wrote:
> On Tue, Jul 5, 2016 at 8:04 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > [Rob]:
> 
> >> Like SPI and I2C, I'm against further abuse of aliases for this purpose
> >> [1].
> 
> So what about the usecase for serial ports, where we use this
> to make sure the console come out where we want it? Is that
> also considered abuse or legitimate use? Note: I'm not trying to be
> snarky, I'm trying to understand what is the right and wrong use
> of alias. I'm confused about it right now :(

I guess it comes down to how ingrained the usage of any numbering is. 
For consoles, it was pretty important to maintain numbering and no 
alternative. But now with stdout-path that is less important. Perhaps if 
you have inittab with tty devices, then it is still needed.

So I guess I would summarize the requirement to be only cases needing to 
maintain numbering for existing userspace. The only users really caring 
about this have been on N900.

Rob
