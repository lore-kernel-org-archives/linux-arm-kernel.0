From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 19:01:34 +0100
Subject: [PATCH 8/9] gpiolib: use gpio_chips list in gpio_to_desc
In-Reply-To: <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdbXvf8mRgpr2MrmcJcT1gTg4mfBOnF8s3=+jS5iAcMtkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Parse the list of chips to find the descriptor corresponding to a GPIO
> number instead of directly picking the entry of the global gpio_desc[]
> array, which is due to be removed.
>
> This turns the complexity of converting a GPIO number into a descriptor
> from O(1) to O(n) where n is the number of GPIO chips in the system.
> Since n is ought to be small anyway, there should be no noticeable
> performance impact. Moreover, GPIO users who care for speed already have
> implemented their own gpio_get_value() and gpio_set_value() with a
> fast path for the GPIO numbers that matter and this change does not
> affect such use cases.
>
> The descriptor-based GPIO API, due to be introduced soon, will make this
> lookup unnecessary.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

OK it's a nice stepping stone.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
