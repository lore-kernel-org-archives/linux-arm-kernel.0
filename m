From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Apr 2015 14:56:11 +0200
Subject: [PATCH 0/2] gpio: Allow userspace export from DT
In-Reply-To: <CAL_JsqJorndYh4ROdKbJfpG1KY=Xosjc6BMFYRPrb+BsauFsnQ@mail.gmail.com>
References: <20150413110515.9681.58848.stgit@localhost>
 <CAL_JsqJorndYh4ROdKbJfpG1KY=Xosjc6BMFYRPrb+BsauFsnQ@mail.gmail.com>
Message-ID: <CACRpkdYw6fY0CKonAO+HtUosjCt5oJjCy3RoRxsDyLCgJCMfLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 3:19 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Mon, Apr 13, 2015 at 6:05 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

>> That number, in the case of gpio drviers using dynamic allocation, is not fixed,
>> and may change when:
>> * The kernel version changes and ARCH_NR_GPIOS is changed (happened in 3.17)
>> * The kernel version changes and probe order changes for gpio chips.
>> * The kernel configuration is changed if CONFIG_ARCH_NR_GPIO is used
>> * The board is redesigned (eg switching an externally visible signal from a
>> SoC provided GPIO to an I2C expander chip or vice versa).
>> * Other GPIO chips are added to the system.
>
> Isn't there some plan/desire to fix the GPIO sysfs interface?

Desire yes. But well noone seems to do it...

There is also the perpetual abuse of sysfs to do things that should
be done in the kernel, like driving LEDs or reading switches.
But that's another problem I guess.

Yours,
Linus Walleij
