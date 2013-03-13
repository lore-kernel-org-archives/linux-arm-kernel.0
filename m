From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 10:03:27 +0100
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <201303121933.47994.arnd@arndb.de>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com> <201303121933.47994.arnd@arndb.de>
Message-ID: <CACRpkdZhS2pbLQ2JDwJ5f5W15OfymMYL_rqdHLws06kLp9zC=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 8:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Rob Herring wrote:
>> On 03/12/2013 12:08 PM, Haojian Zhuang wrote:
>
>> You are breaking existing dtb's changing this, but this is wrong for
>> other reasons. The integrator does not have an SP804. It is the same
>> programming model, but is a single timer and not the dual timer. So
>> having a different compatible string is the correct way. I doubt it has
>> the primecell ID registers which is what "arm,primecell" indicates.
>
> At least the qemu model has the primecell ID only for actual sp804 but
> not for the integrator, see http://git.qemu.org/?p=qemu.git;a=blob;f=hw/arm_timer.c

That is the for the Integrator/CP model right?

Part of the problem with the current patch series is assuming
similarity between the Integrator/AP and Integrator/CP.

The hardware (VHDL code) for the Integrator/CP SP804 block
is certainly based on the Integrator/AP (unnamed "integrator timer")
but many changes were made, the most drastic extending the
counters from 16 to 32 bits.

Yours,
Linus Walleij
