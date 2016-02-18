From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 00:21:51 +0100
Subject: [PATCH v2 4/5] gpio: ep93xx: remove private irq_to_gpio function
In-Reply-To: <1455637261-2920972-4-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-4-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYrUxkOGvxi85zAn8O32otLNGtBGrvQPSqvnm1htp=+-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ep93xx goes through its own back-and-forth dance every time
> it wants to know the gpio number for an irq line, when it really
> just hardcodes a fixed offset in ep93xx_gpio_to_irq().
>
> This removes the pointless macro and replaces the conversion inside
> of the driver with simple add/subtract operations, using an
> explicit macro.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Holding this back waiting for the dependent cleanup to come in.

Yours,
Linus Walleij
