From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 Nov 2013 11:07:21 +0000
Subject: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
In-Reply-To: <1384396537-3486-5-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
Message-ID: <20131114110721.GE16396@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:35:33AM +0000, Tony Lindgren wrote:
> As we claim to support device tree for mach-omap2, we
> should have the necessary flags in the driver to make it
> usable.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.
> 
> ---
>  drivers/i2c/busses/i2c-omap.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

[...]

> +	{
> +		.compatible = "ti,omap2430-i2c",
> +		.data = &omap2430_pdata,
> +	},
> +	{
> +		.compatible = "ti,omap2420-i2c",
> +		.data = &omap2420_pdata,

Please update Documentation/devicetree/bindings/i2c/i2c-omap.txt

Otherwise, this is fine.

Thanks,
Mark.
