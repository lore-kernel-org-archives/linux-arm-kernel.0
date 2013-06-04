From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 4 Jun 2013 02:06:40 -0300
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851CF068@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
 <B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAOMZO5DzVhh4REj5S=cVVVrGzxmTxY9s_h_6ZQ-G8wOxi+KG=A@mail.gmail.com>
 <CAOMZO5Bo58Qa0Rmz+oKt0ZOUjYDDskBsPykCVc79j4mybcG8rA@mail.gmail.com>
 <B56CDBE15CE27145A4B77D2D24263E851CF068@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <CAOMZO5BQ6kef8u4_K3S6vCAa0Ym4HJhg1TcmpYx7i8gFphTnew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 1:55 AM, Lu Jingchang-B35083
<B35083@freescale.com> wrote:

>   From your patch of " serial: imx: Allow module build", I think the code between #ifdef CONFIG_SERIAL_IMX_CONSOLE ... #else in imx.c won't be built because the configuration is CONFIG_SERIAL_IMX_CONSOLE_MODULE now. So it is the same as if disable CONFIG_SERIAL_IMX_CONSOLE when built the driver as a module, isn't it?
>  On other hand, if enable CONFIG_SERIAL_X_CONSOLE option when the driver is configured as module, the build will fail with message like ERROR: "uart_console_device" [drivers/tty/serial/**.ko] undefined! Stephen Rothwel gives the solution once at url:
> http://www.linuxhorizon.com/9-linux/42b33a65f64d95a2.htm
>   I have checked drivers/tty/serial/Kconfig to make sure that other serial drivers indeed did this way.

Maybe we need to use "#if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)"

I will resend the series tomorrow.

Thanks,

Fabio Estevam
