From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 07:37:10 +0200
Subject: [PATCH] gpio: mvebu: correctly set the value in direction_output()
In-Reply-To: <1350980225-6546-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1350980225-6546-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdb+qmH3s8tV1qqL21sL2BNmb7FSWmKPLWMCf0JWOmQ8Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 10:17 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> The ->direction_output() operation of gpio_chip is supposed to set the
> direction to output but also to set the GPIO to an initial
> value. Unfortunately, this last part was not done until now, causing
> for example the LEDs to not be properly set to their default initial
> value. This patch fixes this by calling the mvebu_gpio_set() function
> from mvebu_gpio_direction_output() before configuring the GPIO as an
> output GPIO.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> ---
> As this is a fix, it should most likely go into 3.7.

Yes, thanks. Applied to my "fixes" branch.

Yours,
Linus Walleij
