From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 6 Jun 2013 13:05:19 -0700
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <1370309270-21019-1-git-send-email-b35083@freescale.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
Message-ID: <20130606200519.GA1644@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 09:27:50AM +0800, Jingchang Lu wrote:
> Add Freescale lpuart driver support. The lpuart device
> can be found on Vybrid VF610 and Layerscape LS-1 SoCs.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

This breaks the build on x86 systems with:
  CC [M]  drivers/tty/serial/fsl_lpuart.o
drivers/tty/serial/fsl_lpuart.c: In function ?lpuart_probe?:
drivers/tty/serial/fsl_lpuart.c:751:2: error: implicit declaration of function ?of_alias_get_id? [-Werror=implicit-function-declaration]

so I can't take this :(

greg k-h
