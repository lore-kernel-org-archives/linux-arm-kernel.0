From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 18:11:29 +0200
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <20131010160018.GA29913@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com> <20131010160018.GA29913@atomide.com>
Message-ID: <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 6:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Roger Quadros <rogerq@ti.com> [131010 06:32]:
>>
>> I tried testing this with the USB EHCI driver, but I'm not getting wake up interrupts
>> while the system is still running and only the EHCI controller is runtime suspended.
>>
>> It seems we need to somehow call _reconfigure_io_chain() to update the daisy chain
>> whenever the pad wakeup_enable bit is changed.
>
> Sounds like this is on omap3? Have you tried calling pcs_soc->rearm() in the
> pcs_irq_handle() like the comments there suggest? At least for me that keeps
> the wake-up interrupts continuously running on omap3 instead of just idle modes.

If the rearm() function is calling this _reconfigure_io_chain my comments
on the fact that this is something that should be handled by the pin
control driver still apply I think ....

Yours,
Linus Walleij
