From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jan 2015 10:53:49 +0100
Subject: [PATCH 1/3] gpio: sx150x: move to irqdomain framework for sx150x
 driver
In-Reply-To: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
References: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdaYb3Fnbm5To0Y0tJe1xO-Jb0MdkmR9rsqVEWFEOXviFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 4, 2014 at 1:12 PM, Barry Song <21cnbao@gmail.com> wrote:

> From: Wei Chen <Wei.Chen@csr.com>
>
> The sx150x gpio driver used a loop to set liner irq map for gpio pins.
> Now we use the irq domain to rebuild this irq mappig and make sure the
> codes are still compatible to old users.
>
> this patch also adds IRQF_ONESHOT flag to fix the IRQ flooding issues.
>
> Signed-off-by: Wei Chen <Wei.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Excellent, patch applied.

I added select GPIOLIB_IRQCHIP to the Kconfig though, to
make sure we have the proper library functions.

Yours,
Linus Walleij
