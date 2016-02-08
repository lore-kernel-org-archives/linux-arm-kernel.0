From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 Feb 2016 18:34:29 +0100
Subject: [PATCH V4] drivers/gpio: Switch gpio-mpc8xxx to use gpio-generic
In-Reply-To: <1454498854-33169-1-git-send-email-Gang.Liu@nxp.com>
References: <1454498854-33169-1-git-send-email-Gang.Liu@nxp.com>
Message-ID: <CACRpkdYSwSW+kd+QyvfabNoPyAXx9VDWJaYD79p3krpgmX8iOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 12:27 PM, Liu Gang <Gang.Liu@nxp.com> wrote:

> The new Layerscape platforms has the same ip block/controller
> as GPIO on PowerPC platforms(MPC8XXX), but the GPIO registers
> may be big or little endian. So the code needs to get the
> endian property from DTB, then make additional functions to
> fit all the PowerPC/Layerscape GPIO register read/write
> operations.
>
> gpio-generic.c provides an universal infrastructure for both
> big and little endian register operations. So switch the
> gpio-mpc8xxx to use gpio-generic can simplify the driver and
> reduce a lot of code.
>
> The IRQ and some workaround parts in gpio-mpc8xxx.c will be
> updated with the new API interfaces but following the
> original functionalities.
>
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
> ---
> -V4: Rebase the kernel to v4.5-rc1 for the new gpio-generic
>      infrastructure based on Linus Walleij comments.

Patch applied, I guess this also silences the compile errors I've
been getting about the be32 accessors.

Yours,
Linus Walleij
