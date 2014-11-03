From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Nov 2014 14:45:43 +0100
Subject: [PATCH] leds: leds-gpio: Convert gpio_blink_set() to use GPIO
 descriptors
In-Reply-To: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <CACRpkdaeeAg3M-tf+odar3m8nF=T9gQhkPL+xg0t+3JVvmNnuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 12:40 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Commit 21f2aae91e902aad ("leds: leds-gpio: Add support for GPIO
> descriptors") already converted most of the driver to use GPIO descriptors.
> What is still missing is the platform specific hook gpio_blink_set() and
> board files which pass legacy GPIO numbers to this driver in platform data.
>
> In this patch we handle the former and convert gpio_blink_set() to take
> GPIO descriptor instead. In order to do this we convert the existing four
> users to accept GPIO descriptor and translate it to legacy GPIO number in
> the platform code. This effectively "pushes" legacy GPIO number usage from
> the driver to platforms.
>
> Also add comment to the remaining block describing that it is legacy code
> path and we are getting rid of it eventually.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
