From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Sep 2011 09:13:42 -0700
Subject: [PATCH] ASoC: omap: convert per-board modules to platform drivers
In-Reply-To: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
References: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
Message-ID: <20110908161341.GA3098@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 04:05:53PM +0100, Mans Rullgard wrote:

> +static struct platform_device omap_soc_audio = {
> +	.name	= "omap-soc-audio",
> +	.id	= -1,
> +};
> +

This isn't really accomplishing anything as you're using the same device
name for all boards, it's essentially the same thing as soc-audio just
an OMAP version of that device.  Each machine driver should be a
separate platform driver.
