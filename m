From: marex@denx.de (Marek Vasut)
Date: Mon, 29 Oct 2012 11:22:25 +0100
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
Message-ID: <201210291122.25510.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Vasily Khoruzhick,

[...]

> > 
> > I rather wanted to encourage you to work on the PXA2xx DT stuff :)
> 
> I'm not refusing to work on PXA2xx DT stuff, just want to get bugfixes in
> place, some of them are serious enough (like fixing oops on poweroff)
> 
> > Please have a quick look at arch/arm/mach-pxa/pxa-dt.c - what it takes
> > for basic 270 support is just copying the logic that is there already
> > for the 3xx models.
> 
> Sure, but I need to get DT-capable bootloader working on Z2 in first
> place, right?

Uh, you already have that. U-Boot can boot kernel and pass DT properly, just use 
latest 2012.10 release which just got out a few weeks ago.

> > Some parts like the uart, host-mode usb, mmc, gpio-leds, gpio-keys, i2c
> > etc are already finished and should work instantly. What's missing is
> > the spi controller and the display, but maybe you can help getting these
> > done?
> 
> What about libertas? I still don't understand how DT handles
> platform-specific callbacks like set_power(). And what about pm_power_off
> hook?

Start small, platform crap and DT goo can co-exist for a while.

Best regards,
Marek Vasut
