From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:58:26 +0200
Subject: [PATCH v4] drivers: soc: sunxi: Introduce SoC driver to map SRAMs
In-Reply-To: <1433149466-17013-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1433149466-17013-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <4341126.tsXmi47bFP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 11:04:26 Maxime Ripard wrote:
> The Allwinner SoCs have a handful of SRAM that can be either mapped to be
> accessible by devices or the CPU.
> 
> That mapping is controlled by an SRAM controller, and that mapping might
> not be set by the bootloader, for example if the device wasn't used at all,
> or if we're using solutions like the U-Boot's Falcon Boot.
> 
> We could also imagine changing this at runtime for example to change the
> mapping of these SRAMs to use them for suspend/resume or runtime memory
> rate change, if that ever happens.
> 
> These use cases require some API in the kernel to control that mapping,
> exported through a drivers/soc driver.
> 
> This driver also implement a debugfs file that shows the SRAM found in the
> system, the current mapping and the SRAM that have been claimed by some
> drivers in the kernel.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> Hi Arnd, Kevin, Olof,
> 
> Could you please apply directly this patch to your tree?
> 
> It's the only driver related patch that should come in for this release
> cycle.
> 

Applied to next/drivers. Thanks for your hard work to get it adapted to all
my wishes over your weekend, very much appreciated.

	Arnd
