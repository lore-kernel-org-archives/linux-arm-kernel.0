From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Dec 2016 00:07:36 +0100
Subject: [PATCH linux v1 4/4] arm: dts: Add dt-binding to support seven
 segment display on zaius
In-Reply-To: <20161214114051.GC14217@n2100.armlinux.org.uk>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
 <1481702104-8617-5-git-send-email-jaghu@google.com>
 <3917905.e4iOqADnVQ@wuerfel>
 <10697525.O7CkPN6Gfl@wuerfel> <20161214110635.GB14217@n2100.armlinux.org.uk>
 <20161214114051.GC14217@n2100.armlinux.org.uk>
Message-ID: <CACRpkdaqKDJstfypP0EL9e=TA-atiJmK9zwrBHfLmEVV8SLuAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 12:40 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Looking at this more, it's a SPI driver, presumably because the first
> case where it appeared was on a SPI bus.
>
> However, it's not a SPI device as such, it's a piece of standard,
> general purpose logic that's been around for many years, pre-dating
> the SPI bus.

Indeed.

> I think a much more sensible approach would be to turn the GPIO side
> of the 74x164 driver into a library, which can be re-used by multiple
> bus-specific drivers - one for SPI which allows it to be used in its
> current form, one for our platform bus which takes the GPIO lines for
> the data, clock and clear signals.
>
> I also don't see why they shouldn't use the same compatible - they're
> the same _device_ at the end of the day, just wired up differently.
> It makes the binding documentation a little fun wrt what are required
> and optional properties, but nothing that shouldn't be too difficult.

I agree on both accounts.

Sorry for not seeing this in the first place, I was well aware that this
is a standard component and may be connected in a myriad of ways,
so I should have known better :(

Yours,
Linus Walleij
