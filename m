From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Jul 2014 08:51:48 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
Message-ID: <20140717065148.GT11056@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
> hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.
Just my thought on how to debug that: I'd try to bisect the pci init
routine in the boot loader. I.e. first only do the first half of the
initialisation in U-Boot. Depending on Linux being able to boot or not
initialize more or less on the next run.

Maybe there is a single register write that makes Linux fail?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
