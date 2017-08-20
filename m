From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 20 Aug 2017 17:40:17 +0200
Subject: [RFC 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170820013632.18375-3-afaerber@suse.de>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-3-afaerber@suse.de>
Message-ID: <20170820154017.GD24150@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void rtd119x_rtc_set_enabled(struct device *dev, bool enable)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	val = readl_relaxed(data->base + RTD_RTCEN);
> +	dev_info(dev, "%s: rtcen = 0x%08x\n", __func__, val);

dev_dbg()?

> +static int rtd119x_rtc_open(struct device *dev)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret)
> +		return ret;
> +
> +	val = readl_relaxed(data->base + RTD_RTCACR);
> +	dev_info(dev, "rtcacr = 0x%08x\n", val);

dev_dbg()?

	Andrew
