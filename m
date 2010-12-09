From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 9 Dec 2010 17:29:18 +0000
Subject: [PATCH 8/8] arm: omap: add minimal support for RM-680
In-Reply-To: <alpine.DEB.1.10.1012091905210.22143@esdhcp041196.research.nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
	<1291912764-12823-9-git-send-email-aaro.koskinen@nokia.com>
	<20101209170310.GC2763@pulham.picochip.com>
	<alpine.DEB.1.10.1012091905210.22143@esdhcp041196.research.nokia.com>
Message-ID: <20101209172918.GE2763@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 07:11:28PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Thu, 9 Dec 2010, Jamie Iles wrote:
> >>+static void __init rm680_peripherals_init(void)
> >>+{
> >>+	platform_add_devices(rm680_peripherals_devices,
> >>+				ARRAY_SIZE(rm680_peripherals_devices));
> >>+	rm680_i2c_init();
> >>+	gpmc_onenand_init(board_onenand_data);
> >What happens if CONFIG_MTD_ONENAND_OMAP2=n and
> >CONFIG_MTD_ONENAND_OMAP2_MODULE=n? Do you need to define board_onenand_data to
> >NULL if these aren't enabled?
> [...]
> >>+static void __init rm680_init(void)
> >>+{
> >>+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> >The same here as with the onenand data.
> 
> Check the following commits in linux-omap tree:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=5403187f83c12c6f4c03547e0cc05bac0310be7b
> 
> and
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=7203f8a48bb63015ebe58a6f2a38aec1cb208b9d
Thanks for the pointer! It looks a bit confusing to my eyes but I guess it's 
better than lots of ifdeffery.

Jamie
