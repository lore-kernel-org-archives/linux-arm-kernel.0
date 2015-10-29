From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Oct 2015 14:00:53 +0100
Subject: [PATCH 09/13] clk: versatile-icst: add device tree support
In-Reply-To: <20151026133153.GG8644@n2100.arm.linux.org.uk>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
 <20151015192626.GO4558@codeaurora.org>
 <CACRpkdZUzTsMcFrudF6RRU5_1Njr=8L_XRUEmAWqvEnoJQ96Cw@mail.gmail.com>
 <20151026133153.GG8644@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZvN4yH6AED4aTK-TDLpJuxKOWV2ivU=NiPV1DEJ8nGJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 2:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> [Me]
>> ARM never created any more integrated ICST devices, and
>> they stopped using them since. Those two are the required
>> ones.
>
> As ARM didn't create any ICST devices at all, that's hardly surprising.
> These devices are created by Integrated Circuit Systems, Inc.  The 525
> is a parallel-loaded clock generator, the 307 is a serial-loaded clock
> generator.
>
> However, they have no "standard" software interface - indeed, the 525
> is marketed as a device that needs no processor or software to be used,
> so it doesn't have a "software" interface as such.

RIght, I wrote a blurb with the more elaborate and correct story
for the device tree bindings. I get sloppy sometimes.

> ARM Ltd's hardware on these boards provides interfaces to these, however
> the underlying ICST support I wrote was factored to separate out the
> interface from the chip support - I haven't been tracking what's been
> going on with these, but I hope that separation has been kept as it's
> entirely logical, and describing these things in DT as an ARM Ltd device,
> combining the ICST device itself with its interface would be wrong.

So the device tree bindings does say that, and the compatible strings
are "arm,syscon-icst525" or "arm,syscon-icst307" indicating that it is
indeed the ARM syscon register-mapped thing, and the ICST sits on
the back of that register.

The logical separation is indeed kept, if someone ever decides to
interface the ICST clocks in some other way, the code is reusable.

Yours,
Linus Walleij
