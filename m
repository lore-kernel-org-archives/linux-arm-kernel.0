From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Nov 2013 12:07:03 +0100
Subject: ACPI
In-Reply-To: <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
Message-ID: <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 1:42 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 24 Nov 2013 17:14, "Linus Walleij" <linus.walleij@linaro.org> wrote:

>> For devicetree we have a bit of standardization in
>> Documentation/devicetree/bindings/pinctrl and if I'm not mistaken,
>> nothing of the sort exist in the ACPI spec.
>
> No, none of that exists in ACPI. We're looking at entirely new
> territory for ACPI.
>
> It seems there are two ways we can approach ACPI. 1) we could treat
> ACPI exactly like DT and expect DT bindings to carry over verbatim
> into the ACPI namespace. That means everything we've done with DT we
> expect to show up in ACPI trees including clocks, regulators, pin
> control, etc. Or, 2) assume that if ACPI is being used, then the
> intent is to push responsibility for the platform as a whole
> (system-wide details as opposed to individual devices) out of the
> kernel.

Or (3): ACPI redefined on top of each subsystem. But I get
from the sound of this that this approach is not liked,
because (I assume?) we want to cut some corners.

Example from another architecture:
drivers/gpio/gpio-lynxpoint.c
with infrastructure in:
drivers/gpio/gpiolib-acpi.c

It is a "pure", embedded ACPI driver of the type that Intel is
pushing. They have been very helpful in integrating this
deeply with the GPIO subsystem and are now switching all
relevant drivers to using decriptors rather than GPIO numbers
for embedded x86 which is a big win.

So would ARM ACPI systems with GPIO drivers *not* use this
nice infrastructure ...? (Maybe not your stance but the
sound I hear from some places in this discussion.)

And I cannot see how Intels or anyones pin control, regulator,
clock etc drivers would be any different from this code.

Well, they have indicated that they would prefer to hide some
complex things behind an behind-the-scenes abstraction like
D-states or so, but I have my doubts about that approach,
they may prove me wrong.

Yours,
Linus Walleij
