From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 31 Aug 2016 15:25:00 +0200
Subject: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
In-Reply-To: <E1beLK3-0001TX-SI@rmk-PC.armlinux.org.uk>
References: <20160829120531.GG1041@n2100.armlinux.org.uk>
 <E1beLK3-0001TX-SI@rmk-PC.armlinux.org.uk>
Message-ID: <20160831132500.GA5728@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 01:05:51PM +0100, Russell King wrote:
> Add support for the generic mctrl gpio helper.  This will allow us to
> convert several board files to use the gpiod tables to assign GPIOs to
> serial ports, rather than needing to have private function callbacks.
> 
> If the generic mctrl gpio helper fails, ignore the mctrl gpios rather
> than preventing the (possibly console) serial port from being created.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/tty/serial/Kconfig  |  1 +
>  drivers/tty/serial/sa1100.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
