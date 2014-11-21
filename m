From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 21 Nov 2014 12:57:52 +0100
Subject: [PATCH] ARM: tegra: colibri t30: fix on-module ethernet
In-Reply-To: <b1cdc96ce8bb15059d7eea282f6586a826bee124.1416566157.git.marcel@ziswiler.com>
References: <b1cdc96ce8bb15059d7eea282f6586a826bee124.1416566157.git.marcel@ziswiler.com>
Message-ID: <1416571072.2744.4.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-21 at 11:41 +0100, Marcel Ziswiler wrote:
> Looks like Ethernet only ever worked if U-Boot properly brought it up
> as both the reset as well as the VBUS lines were not actively handled
> in-kernel.
> This patch fixes this by just pulling up the reset GPIO

Doing automatic power-cycle tests revealed that this is still not enough
and a proper reset-cycle might be required. However I don't know as of
yet how one can easily do that in mainline with a USB device otherwise
not mentioned anywhere in the device tree. Any ideas?

> and properly
> enabling VBUS via a GPIO enabled fixed regulator VBUS supply.
> 
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
