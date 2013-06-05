From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Jun 2013 14:41:29 +0200
Subject: [PATCH 00/11] drivers: Add Pinctrl PM support
In-Reply-To: <87k3m92148.fsf@linaro.org>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <20130531170437.GA17591@core.coreip.homeip.net>
 <CACRpkdYnhjpFp1CM=P_hddBe4qVigtE0c+CN9NKvk3nFgJS-ig@mail.gmail.com>
 <87k3m92148.fsf@linaro.org>
Message-ID: <CACRpkdbtVnieRZC+WVNrWZfe2X5SEdcq2ZbOj3kaTm3TLcHmHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 8:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
> [Me]
>> I think this will save a *lot* of identical code in all the
>> drivers, that will just have to call
>> pinctrl_select_pm_sleep(), pinctrl_select_pm_default()
>> pinctrl_select_pm_idle() instead of all the complex code.
>>
>> This is what I planned to do but never got around to.
>
> What about taking it one tiny step further, and having it done by the PM
> core itself?

Maybe so, but atleast currently we cannot do it
exclusively in the PM core.

We have things like what you find in
drivers/tty/serial/amba-pl011.c
where pl011_shutdown() puts the pins into sleep mode
on unused TTYs.

The same applies to any unused ports like that, we're
thinking of a way to sleep pins for unused I2C hosts
for example.

And that works fine also on systems that does not
enable CONFIG_PM (so the pin control subsystem
is completely orthogonal). But maybe that is
complicating things? I was just thinking it was a bit
thick to require everything and its dog to make a
complete transition to (runtime)PM.

Yours,
Linus Walleij
