From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 28 Aug 2017 18:16:27 +0200
Subject: [PATCH v3 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170828111041.17946-3-afaerber@suse.de>
References: <20170828111041.17946-1-afaerber@suse.de>
 <20170828111041.17946-3-afaerber@suse.de>
Message-ID: <20170828161627.4vndoeucudh3rfto@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Seems fine to me, one small comment:

On 28/08/2017 at 13:10:40 +0200, Andreas F?rber wrote:
> +static int rtd119x_rtc_remove(struct platform_device *pdev)
> +{
> +	struct rtd119x_rtc *data = platform_get_drvdata(pdev);
> +
> +	rtd119x_rtc_set_enabled(&pdev->dev, false);
> +
> +	clk_disable_unprepare(data->clk);

Missing clk_put ?

> +
> +	return 0;
> +}
> +
> +static struct platform_driver rtd119x_rtc_driver = {
> +	.probe = rtd119x_rtc_probe,
> +	.remove = rtd119x_rtc_remove,
> +	.driver = {
> +		.name = "rtd1295-rtc",
> +		.of_match_table	= rtd119x_rtc_dt_ids,
> +	},
> +};
> +builtin_platform_driver(rtd119x_rtc_driver);
> -- 
> 2.12.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
