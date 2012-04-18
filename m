From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2012 10:55:56 +0100
Subject: [PATCH 2/2] clk: wm831x: Add initial WM831x clock driver
In-Reply-To: <1334736433-3402-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1334736433-3402-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1334736433-3402-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120418095556.GY24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 09:07:13AM +0100, Mark Brown wrote:
> +static __devexit int wm831x_clk_remove(struct platform_device *pdev)
> +{
> +	struct wm831x_clk *clkdata = dev_get_drvdata(&pdev->dev);
> +
> +	clk_unregister(clkdata->clkout_hw.clk);
> +	clk_unregister(clkdata->fll_hw.clk);
> +	clk_unregister(clkdata->xtal_hw.clk);

And another reason returning error codes from unregister functions is a
bad idea - you've just demonstrated above why that is.  You created this
function which returns an error code, but you're not checking it.
