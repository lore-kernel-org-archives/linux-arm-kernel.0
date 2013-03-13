From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 14:48:07 +0000
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
Message-ID: <1363186087.3100.72.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 12:21 +0000, Haojian Zhuang wrote:
> Do you mean that system wants to pick any one randomly? It's impossible.

It is possible in case of the VE platform. Therefore it is not
completely impossible. QED :-)

> Imagine that only TIMINT1 signal in sp804 is routed to interrupt controller.
> Could system still pick any one it wants?

If you tell the system that only TIMINT1 is wired, it shouldn't even try
to use the second timer for anything that would require the interrupt.
Therefore, describing the hardware sufficiently, you're giving the
system enough information to make the right decisions.

> I think that clocksource or clockevent must be specified in DTS. Whatever
> we're using alias or property.

I'm convinced it does not *must* be there. I think it *can* be there,
for platforms where the available timers are not equal (for whatever
reason). My point is: why are you trying to force me to put some
information into my hardware description which doesn't have any meaning
for me?

Pawe?
