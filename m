From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 12:47:32 +0100
Subject: [PATCH v3 4/6] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <20110926110634.GR31404@pengutronix.de>
References: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
	<1317021651-17359-5-git-send-email-shawn.guo@linaro.org>
	<20110926110634.GR31404@pengutronix.de>
Message-ID: <20110926114732.GF22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 01:06:34PM +0200, Sascha Hauer wrote:
> +config ARCH_IMX_V6_V7
> +	bool "i.MX3, i.MX6"
> +	select AUTO_ZRELADDR

It's not a good idea to select this symbol, because it prevents ZBOOT_ROM
being used (iow, you can't ROM-ify the decompressor if you select this
symbol.)

ZBOOT_ROM is still offered, but you end up breaking the dependencies for
AUTO_ZRELADDR if you select it.
