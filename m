From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Oct 2016 12:47:54 +0200
Subject: [v15, 6/7] base: soc: introduce soc_device_match() interface
In-Reply-To: <1477637418-38938-7-git-send-email-yangbo.lu@nxp.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <1477637418-38938-7-git-send-email-yangbo.lu@nxp.com>
Message-ID: <2572890.e6aV4hmMEL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 28, 2016 2:50:17 PM CEST Yangbo Lu wrote:
> +
> +static int soc_device_match_one(struct device *dev, void *arg)
> +{
> +       struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> +       const struct soc_device_attribute *match = arg;
> +
> +       if (match->machine &&
> +           !glob_match(match->machine, soc_dev->attr->machine))
> +               return 0;
> +
> +       if (match->family &&
> +           !glob_match(match->family, soc_dev->attr->family))
> +               return 0;
> +
> 

Geert found a bug in my code, and submitted a fix at
https://patchwork.kernel.org/patch/9361395/

I think you should include that one in your series.

	Arnd
