From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 25 Apr 2012 19:49:56 +0800
Subject: [PATCH v2 1/2] pinctrl: add pinctrl_provide_dummies interface
 for platforms to use
In-Reply-To: <CACRpkdYjVYsM-Qo7NWKx5Mr3rAmp12G_wAtkmNkkqNyX=ZeKUw@mail.gmail.com>
References: <1335260023-15859-1-git-send-email-b29396@freescale.com>
 <4F96F847.508@wwwdotorg.org>
 <20120425094934.GA17631@shlinux2.ap.freescale.net>
 <CACRpkdYjVYsM-Qo7NWKx5Mr3rAmp12G_wAtkmNkkqNyX=ZeKUw@mail.gmail.com>
Message-ID: <20120425114955.GB17631@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 07:19:43PM +0800, Linus Walleij wrote:
> On Wed, Apr 25, 2012 at 11:49 AM, Dong Aisheng
> <aisheng.dong@freescale.com> wrote:
> > On Wed, Apr 25, 2012 at 03:00:23AM +0800, Stephen Warren wrote:
> 
> >> The only thing that should be calling pinctrl_request_gpio() is a GPIO
> >> driver. It should only be calling it for the GPIOs it manages. I'd
> >> expect that if a platform's pinctrl driver was not yet written to
> >> support the GPIO functionality, then the GPIO driver would not be
> >> calling this function.
> >>
> > Hmm, pinctrl gpio is in the same situation as pinctrl state that gpio
> > driver may be shared between several platforms, with pinctrl support
> > or not.
> 
> I think it's mostly safe to assume that either:
> 
I just saw your reply after i sent out the revised patch...

> - pinctrl calls from GPIO drivers gets stubbed out totally due to
>   CONFIG_PINCTRL not being selected
> 
Yes, we already have that in include/linux/pinctrl/consumer.h

> or:
> 
> - You need to pass a token through platform data to the
>   GPIO driver telling it whether it needs to request pins for
>   it's GPIOs or not. Just a bool should work fine?
> 
Yes, this is an alternative way.
I'm using a similar way, but pass the data to pinctrl core
rather than gpio driver. Then it is be handled together with
dummy state in platform code.

Do you think if the current way i used is ok?
Or i need to change to your proposed way?

Regards
Dong Aisheng
