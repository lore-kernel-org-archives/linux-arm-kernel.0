From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Feb 2018 10:13:10 +0100
Subject: [PATCH v3 0/4] gpio: driver for the RPi3 GPIO expander
In-Reply-To: <20180206162759.awghecpv4ihaatz7@tarshish>
References: <cover.1516105893.git.baruch@tkos.co.il>
 <CACRpkdZAtVfAU-k9EUihH6peY2d1Ntn3jboVMBn9adReNLupow@mail.gmail.com>
 <20180206162759.awghecpv4ihaatz7@tarshish>
Message-ID: <CACRpkdYGYtF5iw=ZDF9O5LdwfvktEfDORjYXZDmFNihVSP+c3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 6, 2018 at 5:27 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> On Tue, Feb 06, 2018 at 02:42:48PM +0100, Linus Walleij wrote:
>> On Tue, Jan 16, 2018 at 1:45 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>>
>> > The Raspberry Pi 3 has a GPIO expander that controls, among others, the
>> > activity LED, and the camera connector GPIOs. The GPIO expander on an I2C bus
>> > that is not directly controlled from the ARM core. The VC4 firmware controls
>> > the I2C bus, and allows the ARM core to set/get GPIO settings over its mailbox
>> > interface.
>> >
>> > This series adds support for the RPi3 expander.
>> >
>> > The driver is ported from the downstream kernel at
>> > https://github.com/raspberrypi/linux/, branch rpi-4.9.y.
>> >
>> > Changes in v3:
>> >
>> >   * Kconfig tweaks
>> >   * Check rpi_exp_gpio_get_polarity() return value
>> >   * Redundant header removal
>> >   * Redundant platform_set_drvdata() call removal
>> >   * Small coding style changes
>>
>> All is looking pretty good. I see Rob had some last minute comments,
>> but please rebase and repost post v4.16-rc1 so we can get this merged,
>> we need to get this upstream.
>
> I was about to send v4 when I saw your email. I based v4 on current LinusT's
> tree as of e237f98a9c. I guess that affected files will not change before
> v4.16-rc1, but I can wait a few more days for -rc1.

It's fine to send if you feel it is ready. I am already queueing
stuff for v4.17.

Yours,
Linus Walleij
