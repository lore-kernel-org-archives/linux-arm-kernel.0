From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Aug 2012 14:06:10 +0100
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <CACRpkdYkoeH09H6c4WEw40hpP9+oRD4pa0-yBk1L02yfao2sgg@mail.gmail.com>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
 <1344426500.2435.39.camel@hornet>	<1344426753.2435.40.camel@hornet>
 <CACRpkdYkoeH09H6c4WEw40hpP9+oRD4pa0-yBk1L02yfao2sgg@mail.gmail.com>
Message-ID: <1344431170.2435.47.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-08 at 12:55 +0100, Linus Walleij wrote:
> On Wed, Aug 8, 2012 at 1:52 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> 
> >> ------------[ cut here ]------------
> >> WARNING: at /home/pawmol01/src/kernel.org/linux/kernel/timer.c:1076 del_timer_sync+0x34/0x5c()
> >
> > Err. Ignore that. The same happens without your patch :-)
> >
> > Will try with 3.5.
> 
> Hm it boots like a charm on PB1176, what's so very different about the EB?

It's configuration difference, I guess. You may try enabling
CONFIG_LEDS_TRIGGERS (not that it makes much sense on Realview) if you
want to see the same effect :-)

It seems that a0193cbee0809d65362a0767b2d50306b145b2f5 "leds: use
led_set_brightness in led_trigger_event" causes a problem when
led_trigger_event() is called from an interrupt context. I'll let the
LEDS people know.

> Oh well. Are you maintaining RealView EB, BTW?

Not really. At least I didn't have any reason to do this so far. And the
only Realview platforms I'm really interested in are the EB models. DT
for Realview is on my todo list, but with really low priority (around
"most likely will never happen").

Anyway, after testing your change on EB model:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawe?
