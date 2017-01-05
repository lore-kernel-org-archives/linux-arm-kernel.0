From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Jan 2017 07:45:09 +0000
Subject: [PATCH 1/2] mfd: micon: Add Buffalo Kurobox Pro, Terastation II
 Pro/Live driver
In-Reply-To: <3e9b7bfe-8305-64fc-f175-e612576d58a7@gmail.com>
References: <20161229000137.5553-1-f.fainelli@gmail.com>
 <20161229000137.5553-2-f.fainelli@gmail.com>
 <20170104112227.GA27589@dell>
 <3e9b7bfe-8305-64fc-f175-e612576d58a7@gmail.com>
Message-ID: <20170105074509.GF24225@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jan 2017, Florian Fainelli wrote:

> Le 01/04/17 ? 03:22, Lee Jones a ?crit :
> > On Wed, 28 Dec 2016, Florian Fainelli wrote:
> > 
> >> This driver is currently only used to reboot the devices, but the
> >> microcontroller hanging off UART1 on the Buffalo Kurobox Pro and
> >> Terastation II Pro/Live is capable of a lot more than that, which we
> >> will support in subsequent patches. For now, just add the reboot
> >> functionality to make the kernel reboot correctly.
> > 
> > This is not an MFD driver.  You have written a UART driver.
> > 
> > Please relocate it to drivers/char/tty/serial.
> 
> Not that simple, and as explained in the cover letter the UART attached
> micro controller can do a lot more than just reboot the machine, but

That's fine.  This is precisely why we have MFD.  But the core (MFD)
driver should only conduct set-up of shared resources, registration of
child devices and maybe some shared functionality required by >1 child
device.  All child device (i.e. UART) capability should be handled by
the child drivers.

> someone else is working on the driver, so this patch series can be ignored.

Okay.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
