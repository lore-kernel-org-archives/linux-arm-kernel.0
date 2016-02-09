From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 9 Feb 2016 11:19:57 +0100
Subject: [PATCH 0/2] CREG clk driver for NXP LPC18xx family
In-Reply-To: <20160208222637.GV4848@codeaurora.org>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
 <20160208222637.GV4848@codeaurora.org>
Message-ID: <CAGhQ9Vy14XR+-kgACiqPgs0SPueizD6Gd2q5kaNqM5mGna0V=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 8 February 2016 at 23:26, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/11, Joachim Eastwood wrote:
>> This patch set adds a clk driver for the low power clocks found in
>> the CREG block on lpc18xx. CREG is a collection of miscellaneous
>> configuration registers that can be accessed through a syscon
>> regmap interface. The clk driver makes it possible to setup and
>> enabled these two clocks.
>>
>> This need to support peripherals like the internal RTC on the
>> lpc18xx platform.
>>
>
> I know this is many months old, but is this driver still
> required? I can apply it to clk-next if so.

It is still needed for the internal RTC (rtc-lpc24xx) on lpc18xx. The
RTC uses a 1 kHz clock that is controlled in CREG (misc system regs).

Note; if you apply it you will most likely get a very trivial conflict
in drivers/clk/nxp/Makefile because clk-lpc32xx.c has been added since
these patches was sent.


regards,
Joachim Eastwood
