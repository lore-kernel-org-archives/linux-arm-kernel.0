From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 11 Mar 2015 14:01:05 +0100
Subject: [PATCH] serial: mctrl-gpio: fix build warning
In-Reply-To: <2661449.5Eht12RCUu@wuerfel>
References: <2661449.5Eht12RCUu@wuerfel>
Message-ID: <20150311130105.GB16733@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 11:25:41AM +0100, Arnd Bergmann wrote:
> A recent fix to the error handling in this driver introduced a
> harmless warning:
> 
> serial/serial_mctrl_gpio.c: In function 'mctrl_gpio_init':
> serial/serial_mctrl_gpio.c:110:4: warning: return makes pointer from integer without a cast
> serial/serial_mctrl_gpio.c:90:6: warning: unused variable 'err' [-Wunused-variable]
> 
> This removes the unused variable and uses the ERR_CAST helper
> to return the error value as the correct type.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1d267ea6539f2 ("serial: mctrl-gpio: simplify init routine")

Someone else sent me this before you did, sorry.

greg k-h
