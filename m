From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 8 Mar 2017 13:34:17 +0100
Subject: [PATCH] serial: 8250: 8250_core: Use dev_name() during
 request_irq()
In-Reply-To: <20170308121943.29340-1-vigneshr@ti.com>
References: <20170308121943.29340-1-vigneshr@ti.com>
Message-ID: <20170308123417.GA3981@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 05:49:43PM +0530, Vignesh R wrote:
> Passing "serial" as name during request_irq() results in all serial port
> irqs have same name. This does not help much to easily identify which
> irq belongs to which serial port instance. Therefore pass dev_name()
> during request_irq() so that better identifiable name is listed for
> serial ports in cat /proc/interrupts output.
> 
> Output of cat /proc/interrupts
> Before this patch:
>  26:        689          0     GICv2 309 Edge      serial
> After this patch:
>  26:        696          0     GICv2 309 Edge      2530c00.serial
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

I need a "full" name here, unless you really do sign legal documents
with just one letter as a last/sur-name?

thanks,

greg k-h
