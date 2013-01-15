From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jan 2013 13:36:47 +0000
Subject: [RFC PATCH 1/7] drivers: usb: phy: add a new driver for usb part
 of control module
In-Reply-To: <1358239378-10030-2-git-send-email-kishon@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
 <1358239378-10030-2-git-send-email-kishon@ti.com>
Message-ID: <201301151336.47546.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 January 2013, Kishon Vijay Abraham I wrote:
> +OMAP CONTROL USB
> +
> +Required properties:
> + - compatible: Should be "ti,omap-control-usb"
> + - reg : Address and length of the register set for the device. It contains
> +   the address of "control_dev_conf" and "otghs_control".
> + - reg-names: The names of the register addresses corresponding to the registers
> +   filled in "reg".
> + - ti,has_mailbox: This is used to specify if the platform uses mailbox in
> +   control module.

I wonder whether we need to have a phandle here to connect the control device
to the actual usb device. What happens if you have multiple instances of
each?

	Arnd
