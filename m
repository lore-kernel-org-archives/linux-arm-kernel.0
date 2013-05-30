From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 22:03:58 +0200
Subject: [PATCH 1/2] gpiolib: add gpio_export_with_name
In-Reply-To: <51A719A5.50906@epfl.ch>
References: <20121121101259.GQ4398@game.jcrosoft.org>
 <1353492849-29397-1-git-send-email-plagnioj@jcrosoft.com>
 <20121126135911.2F1D33E187C@localhost> <51A719A5.50906@epfl.ch>
Message-ID: <CACRpkdb9F+wJ0hkNqPTP34r3JAEp2s07Q8U24fD6oCdj7MqCFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 11:19 AM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:

> Even if work is progressing towards
> having gpio-controlled reset pins [1], some boards still need GPIOs to
> be exported to userspace for other functionalities.

Which are these?

When I have inquired I have heard all kind of horrible things:

- Userspace replicating drivers/leds/leds-gpio.c to
  turn on/off and even PWM (!) LEDs from userspace, when we have
  a standard sysfs interface for LEDs.

- Userspace replicating drivers/input/keyboard/gpio_keys[_polled].c
  to "just read this one button" instead of going through the
  Linux input subsystem like everyone else.

- Userspace replicating drivers/regulator/gpio-regulator.c
  to "turn on just this one voltage source".

All invalid reasons for using the sysfs ABI and trying to do the
kernels work. All creating horrs for users and developers who now
have to stash everything were trying to stach into the device tree
(the above is all perfectly expressed with DT nodes) into their
userspace app and then requiring their users to match a certain
app to a certain board.

The only examples I've really come to accept considers using
things like relays and switches on factory lines where the meaning
(semantics) of the GPIOs can only be properly understood from the
GUI in the userspace APP running that factory line. Or robotics.
In both cases presumably RT processes.

Yours,
Linus Walleij
