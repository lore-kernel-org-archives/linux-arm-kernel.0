From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 May 2012 22:58:12 +0200
Subject: [PATCH 06/18] mfd: ab8500: Remove confusing ab8500-i2c file and
 merge into ab8500-core
In-Reply-To: <1337262323-27692-7-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZWVpuZAmXV4fKTEvV7ke=NDGsej2iTSKdVy_e7gC9QQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 3:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> ab8500-i2c is used as core code to register the ab8500 device.
> After allocating ab8500 memory, it immediately calls into
> ab8500-core where the real initialisation takes place. This
> patch moves all core registration and memory allocation into
> the true ab8500-core file and removes ab8500-i2c completely.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
(...)
> +static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data)

So what happened to the promised (optional as add-on) patch also
renaming these functions to ab8500_prcmu_write() etc?

The reason I insist on not ACK:in on a "promise to fix later, really
sure"-basis is exactly that these things tends to be forgotten ;-)

Yours,
Linus Walleij
