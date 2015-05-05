From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 May 2015 17:16:49 +0200
Subject: [PATCH v3 1/1] pinctrl: at91: Add set_multiple GPIO chip feature
In-Reply-To: <1427968549-19837-1-git-send-email-alexanders83@web.de>
References: <1427968549-19837-1-git-send-email-alexanders83@web.de>
Message-ID: <CACRpkdY-osqmFqq0N9UuLfvBowjoa8cjORuL0GYMntne7AatHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 2, 2015 at 11:55 AM, Alexander Stein <alexanders83@web.de> wrote:

> This adds the callback for set_multiple.
> As this controller has a separate set and clear register, we can't write
> directly to PIO_ODSR as this would required a cached variable and would
> race with at91_gpio_set.
> So build masks for the PIO_SODR and PIO_CODR registers and write them
> together.
>
> Signed-off-by: Alexander Stein <alexanders83@web.de>
> ---
> I Just realized that some implementations have less than 32 pins. Thus
> BITS_MASK(chip->ngpio) as suggested by Jean-Christophe is actually required.
> I missed that, sorry for the noise.
>
> Changes in v3:
> * As not all GPIO controllers have 32 pins take ngpio into account
>   Mask the set- and clear-mask to the supported GPIO pins

No more comments on v3 so patch applied for v4.2.

Yours,
Linus Walleij
