From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Mar 2012 21:30:13 +0000
Subject: [PATCH] USB: gadget driver for LPC32xx
In-Reply-To: <1332191930-2433-1-git-send-email-stigge@antcom.de>
References: <1332191930-2433-1-git-send-email-stigge@antcom.de>
Message-ID: <201203192130.13583.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 March 2012, Roland Stigge wrote:
> This patch adds a USB gadget driver.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> ---
> 
> Applies to v3.3
> 
> 
>  drivers/usb/gadget/Kconfig        |   10 
>  drivers/usb/gadget/Makefile       |    1 
>  drivers/usb/gadget/gadget_chips.h |    3 
>  drivers/usb/gadget/lpc32xx_udc.c  | 3598 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 3612 insertions(+)

Hi Roland,

There is already a driver for the isp1301 otg part in the kernel, I don't
think we want to add another one.

>From what I can tell, this shares a common ancestry with the omap version
but has diverged quite a bit. The best solution would really be to
bring the two back together and let them share a common base driver,
with the lpc32xx and omap specific bits in another file.

	Arnd
