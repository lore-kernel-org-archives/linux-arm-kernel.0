From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 20:25:35 +0200
Subject: GPIO sysfs : set a wake source
In-Reply-To: <87k3mwv6ru.fsf@free.fr>
References: <87fvxwia0s.fsf@free.fr>
 <CACRpkdYjQD9phVtWNh2QGkZWOdEJyZENnYatXt7bd23bgqXitw@mail.gmail.com>
 <51926177.1050600@wwwdotorg.org> <87ip2ig1ez.fsf@free.fr>
 <CACRpkdbiZFutP_+u=ciuC6r-8N5FpkEnGVLH9LGDQ7pvdo3_-Q@mail.gmail.com>
 <87k3mwv6ru.fsf@free.fr>
Message-ID: <CACRpkdYX4w-efLMZKbEg4MS2odGi9jhj5FssNyi=LEhf32-P6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 11:18 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

>> I think you need to think about how we join this modem closer
>> with the kernel instead of trying to paper it over using userspace
>> GPIO.

> Why ? I has only one UART and several GPIOs. What good would it be to add it in
> kernel ?

Because of the Subject: of this email.

You are starting to set up interrupts and wakeup sources and
other kernel proprietary stuff from userspace and basically (IMO)
trespassing on kernel territory.

>> I think the dilemma faced by embedded modems need to
>> be considered thoroughly here.
>
> As I said, it's an "old" modem. And if by embedded you mean "embedded in the
> SoC", it's not, it's a separate chip. The interconnect are the UART lines and
> the GPIO lines (solder lines as you pointed out).

I do not worry about the age of the modem. I would have thought
the same if you took the PCB out of a Robotics 28K8 and soldered
it onto some chipset and soldered a wakeup line on a GPIO pin.

I worry about userspace getting to know everthing about interrupts
and wake up sources and it just IMO *shouldn't*. I don't think
userspace should know anything about IRQs beside /proc/interrupts
but I'm CC:ing tglx so he can say something here.

Yours,
Linus Walleij
