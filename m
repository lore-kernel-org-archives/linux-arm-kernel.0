From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 4 Jun 2017 22:55:16 +0200
Subject: [PATCH v2 4/4] net: macb: Add hardware PTP support
In-Reply-To: <1496413690-22826-1-git-send-email-rafalo@cadence.com>
References: <1496413439-12900-1-git-send-email-rafalo@cadence.com>
 <1496413690-22826-1-git-send-email-rafalo@cadence.com>
Message-ID: <20170604205516.GA7848@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 03:28:10PM +0100, Rafal Ozieblo wrote:

> +int gem_get_hwtst(struct net_device *dev, struct ifreq *rq)
> +{
> +	struct macb *bp = netdev_priv(dev);
> +	struct hwtstamp_config *tstamp_config = &bp->tstamp_config;
> +
> +	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
> +		return -EFAULT;

Segmentation fault?  Really?

...

> +int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd)
> +{
> +	struct macb *bp = netdev_priv(dev);
> +	struct hwtstamp_config *tstamp_config = &bp->tstamp_config;
> +	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
> +	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
> +	u32 regval;
> +
> +	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
> +		return -EFAULT;

here again

Thanks,
Richard
