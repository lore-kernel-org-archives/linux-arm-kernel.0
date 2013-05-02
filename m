From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 2 May 2013 18:38:36 +0200
Subject: [PATCH 1/7] ARM: u300: push down syscon registers
In-Reply-To: <201305021821.12008.arnd@arndb.de>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
 <1367511416-4312-2-git-send-email-linus.walleij@stericsson.com>
 <201305021821.12008.arnd@arndb.de>
Message-ID: <CACRpkdayJCm-PcY_=+NDraEPn0m6BrjNRH+tYp3Abar43RamaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 2, 2013 at 6:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 02 May 2013, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> Get rid of the <mach/syscon.h> header as a prerequisite for
>> multiplatform support. Do this by pushing the registers down
>> to their respective drivers and deleting the unused remainder.
>>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Mike: I'm seeking an ACK for this to take it through the
>> ARM SoC tree alongside the big bowl of DT enablement patches.
>> ---
>
> How do those drivers get to the SYSCON base address? Should they
> be using drivers/mfd/syscon.c as the multiplexor instead?

No, there is no mutex to be taken. The consecutive range of memory
addresses are used by different things (mainly the clocks) but there
is no register that needs to be protected against access from two
subsystems simultaneously.

As a follow-up to this series I plan to move also the U300 clocks
to the device tree (similar three-step ladder as used for the Nomadik)
and then they will (hopefully) get the syscon base address from the
device tree.

Yours,
Linus Walleij
