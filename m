From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Apr 2014 09:10:33 -0700
Subject: [PATCH 11/11] pinctrl: single: Clear pin interrupts enabled by
 bootloader
In-Reply-To: <CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-12-git-send-email-tony@atomide.com>
 <CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
Message-ID: <20140422161033.GC19317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [140422 04:55]:
> On Fri, Apr 11, 2014 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Since we set up device wake-up interrupts as pinctrl-single
> > interrupts, we now must use the standard request_irq and
> > related functions to manage them.
> >
> > If the pin interrupts are enabled for some pins at boot,
> > the wake-up events can show up as constantly pending
> > at least on omaps and will hang the system unless the related
> > device driver clears the event at the device.
> >
> > To fix this, let's clear the interrupt flags during init,
> > and print out a warning so the board maintainers can update
> > their drivers to do proper request_irq for the driver specific
> > wake-up events.
> >
> > Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Looks clean.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Shall I apply this patch or will you funnel it through ARM SoC
> due to deps?

No deps except boards hanging without it.. Please feel free to
take this one, prererrably as a fix for the -rc series if no
objections.

Regards,

Tony
