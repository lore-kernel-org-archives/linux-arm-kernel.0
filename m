From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jan 2013 11:51:22 +0100
Subject: [PATCH] gpio: vt8500: memory cleanup missing
In-Reply-To: <1357163240-23131-1-git-send-email-linux@prisktech.co.nz>
References: <1357163240-23131-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdYwn0uc1Nk+RMcx_AaZ5o6k2ug1rAAJrJCGNb9J4MwWhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 2, 2013 at 10:47 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> This driver is missing a .remove callback, and the fail path on
> probe is incomplete.
>
> If an error occurs in vt8500_add_chips, gpio_base is not unmapped.
> The driver is also ignoring the return value from this function so
> if a chip fails to register it completes as successful.
>
> Replaced pr_err with dev_err in vt8500_add_chips since the device is
> available.
>
> There is also no .remove callback defined. To allow removing the
> registered chips, I have moved *vtchip to be a static global.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Applied to fixes, thanks!

Yours,
Linus Walleij
