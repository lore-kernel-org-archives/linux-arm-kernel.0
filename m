From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Jan 2016 10:07:51 +0100
Subject: [PATCH -next] gpio: xilinx: Do not use gpiochip_get_data() in
 xgpio_save_regs()
In-Reply-To: <1452126010-1111-1-git-send-email-linux@roeck-us.net>
References: <1452126010-1111-1-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkdYG77Q30J4hodKEqR2Cth==XfyqU5wi5gk3wz+YS6qJ8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 1:20 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Commit 097d88e94c44 ("gpio: xilinx: use gpiochip data pointer") replaces
> the use of container_of() with gpiochip_get_data(). Unfortunately, the
> data pointer is not yet set by the time xgpio_save_regs() is called,
> causing a system hang.
>
> Fixes: 097d88e94c44 ("gpio: xilinx: use gpiochip data pointer")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> It might make sense to merge this patch with the patch introducing the problem.

Patch applied, thanks for finding and fixing this so quick!

(I hope I haven't created too many of these regressions...)

Yours,
Linus Walleij
