From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 May 2010 11:12:01 +0100
Subject: [PATCH 1/2] i.MX ssi: MX31ads sound support should depend on
	MACH_MX31ADS
In-Reply-To: <1275295794-3168-2-git-send-email-s.hauer@pengutronix.de>
References: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
	<1275295794-3168-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100531101200.GA3489@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 10:49:53AM +0200, Sascha Hauer wrote:

>  config SND_MXC_SOC_WM1133_EV1
>  	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
> -	depends on SND_IMX_SOC && EXPERIMENTAL
> +	depends on SND_IMX_SOC && MACH_MX31ADS && EXPERIMENTAL

This should depend on the 1133-EV1, not the core machine.  The module
has a dependency on the core machine already and is required to use the
drivers.
