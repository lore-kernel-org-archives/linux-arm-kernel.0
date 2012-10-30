From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Oct 2012 23:16:26 +0100
Subject: [PATCH] mvebu-gpio: Disable blinking when enabling a GPIO for
 output
In-Reply-To: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
References: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
Message-ID: <CACRpkdY-aAxJpA7qvKWzxLRC-5_eC6cOZr7wsTLsFprOSbJ6CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 1:23 PM, Jamie Lentin <jm@lentin.co.uk> wrote:

> The plat-orion GPIO driver would disable any pin blinking whenever
> using a pin for output. Do the same here, as a blinking LED will
> continue to blink regardless of what the GPIO pin level is.
>
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> The power LED on the DNS-320/DNS-325 is left blinking by the bootloader,
> the LED turning steady indicates it's booted. The blinking needs to be
> disabled before setting the GPIO pin level has any effect.
>
> Apart from the custom init code running too soon, I think everything is
> working now.
>
> I haven't tested this on any other boards, so not sure if it's sensible
> beyond the kirkwood/orion world.

Can I have some ACK on this thing from Andrew or Thomas say...

Also is this a thing for the stable kernel -rc series or next
merge window? I couldn't quite figure out if it was a regression.

Yours,
Linus Walleij
