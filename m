From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 2 Apr 2017 15:55:58 +0300
Subject: [PATCH v2 3/5] serial: small Makefile reordering
In-Reply-To: <20170401222119.25106-4-nicolas.pitre@linaro.org>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <20170401222119.25106-4-nicolas.pitre@linaro.org>
Message-ID: <CAHp75VdFBSWmEk9e3bFKu3Kx7EjigrrFrL82+iRsxrW7dC1FoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 2, 2017 at 1:21 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Move 21285 entry down alongside other UART drivers to be more consistent
> with the rest of the file. It is kept before 8250 though, to preserve the
> existing link ordering between those two.

I did once for entire Makefile (some logical reordering), but Greg
objected it. Perhaps you can sell it better.

http://www.spinics.net/lists/linux-serial/msg23616.html

>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  drivers/tty/serial/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 2d6288bc45..53c03e0051 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -3,7 +3,6 @@
>  #
>
>  obj-$(CONFIG_SERIAL_CORE) += serial_core.o
> -obj-$(CONFIG_SERIAL_21285) += 21285.o
>
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
> @@ -17,6 +16,8 @@ obj-$(CONFIG_SERIAL_SUNZILOG) += sunzilog.o
>  obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
>  obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
>
> +obj-$(CONFIG_SERIAL_21285) += 21285.o
> +
>  # Now bring in any enabled 8250/16450/16550 type drivers.
>  obj-$(CONFIG_SERIAL_8250) += 8250/
>
> --
> 2.9.3
>



-- 
With Best Regards,
Andy Shevchenko
