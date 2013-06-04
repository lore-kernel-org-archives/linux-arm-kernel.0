From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 3 Jun 2013 23:54:42 -0300
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <1370309270-21019-1-git-send-email-b35083@freescale.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
Message-ID: <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 3, 2013 at 10:27 PM, Jingchang Lu <b35083@freescale.com> wrote:

> +config SERIAL_FSL_LPUART
> +       tristate "Freescale lpuart serial port support"
> +       select SERIAL_CORE
> +       help
> +         Support for the on-chip lpuart on some Freescale SOCs.
> +
> +config SERIAL_FSL_LPUART_CONSOLE
> +       bool "Console on Freescale lpuart serial port"

It is better yo use tristate here as well.

I have just sent the same fix for imx serial.

Keeping it bool may lead to build error when SERIAL_FSL_LPUART=m and
SERIAL_FSL_LPUART_CONSOLE=y

Regards,

Fabio Estevam
