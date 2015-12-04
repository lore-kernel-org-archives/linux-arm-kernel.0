From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 4 Dec 2015 10:57:13 -0800
Subject: [PATCH 2/3] Add support for monitoring gpio switches
In-Reply-To: <1449250275-23435-3-git-send-email-martyn.welch@collabora.co.uk>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <1449250275-23435-3-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <20151204185713.GA22925@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 05:31:14PM +0000, Martyn Welch wrote:
> Select Chromebooks have gpio attached to switches used to cause the
> firmware to enter alternative modes of operation and/or control other
> device characteristics (such as write protection on flash devices). This
> patch adds a driver that exposes a read-only interface to allow these
> signals to be read from user space.
> 
> This functionality has been generalised to provide support for any device
> with device tree support which needs to identify a gpio as being used for a
> specific task.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>  drivers/misc/Kconfig       |  11 ++++
>  drivers/misc/Makefile      |   1 +
>  drivers/misc/gpio-switch.c | 160 +++++++++++++++++++++++++++++++++++++++++++++

Why isn't this in drivers/gpio/ ?

why make it a misc driver?

thanks,

greg k-h
