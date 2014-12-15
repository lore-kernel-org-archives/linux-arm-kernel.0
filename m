From: pavel@denx.de (Pavel Machek)
Date: Mon, 15 Dec 2014 23:34:40 +0100
Subject: [PATCH v3 2/3] ARM: socfpga: Add driver for the L3 interconnect
In-Reply-To: <1417292052-12974-3-git-send-email-s.trumtrar@pengutronix.de>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
 <1417292052-12974-3-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20141215223440.GC27866@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The L3 interconnect provides Global Programmer View (GPV) registers for every
> AXI master and slave on the SoC.
> Although this is just a bunch of bits, syscon is not the right approach for
> this IP core.
> The L3 interconnect is configured with a lot of reserved "holes" in its memory
> space. Just mapping this with regmap, what syscon would do, would lead to the
> system completely hanging, if one of those areas would be touched.
> One example for when this might happen is the regmap registers dump in the
> debugfs.

Could syscon be extended to take more than one range? Then, you could
simply list all the ranges in device tree and use syscon...

> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 76d6bd4da138..11db07da894f 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -1,6 +1,7 @@
>  menu "SOC (System On Chip) specific Drivers"

SoC is usual spelling.

> @@ -0,0 +1,10 @@
> +#
> +# SoCFPGA Soc drivers

SoC.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
