From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Sep 2012 14:19:07 +0000
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <CACRpkdYy2CZXXA+kkEaOTznaucxXEwiwSn-5ux0ByHjXrsm-2A@mail.gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <5048A31E.2090704@gmail.com>
 <CACRpkdYy2CZXXA+kkEaOTznaucxXEwiwSn-5ux0ByHjXrsm-2A@mail.gmail.com>
Message-ID: <201209061419.07325.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 September 2012, Linus Walleij wrote:
> On Thu, Sep 6, 2012 at 3:20 PM, Rob Herring <robherring2@gmail.com> wrote:
> > [Me]
> >> I can of course skip the aliases and go for the timer nodes
> >> I want directly, but that isn't any helpful for people reading the
> >> device tree, is it?
> >
> > Well, the dts doesn't really need to describe how Linux is using things.
> 
> The arm,integrator-clocksource and arm,integrator-clockevent
> are renamed arm,timer-primary and arm,timer-secondary in the
> last patch set.
> 
> Are you OK with this for now, going forward? I'd be happy to
> take a round refactoring it for the next cycle as outlined
> below.

If the timers are really free for use by anything and you want to
encode how Linux uses them, I would suggest naming the aliases
"linux.clocksource" and "linux,clockevent" to make it clear that
you are not describing the hardware here but rather picking
a configuration.

	Arnd
