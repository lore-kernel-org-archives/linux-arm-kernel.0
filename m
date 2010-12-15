From: shemminger@vyatta.com (Stephen Hemminger)
Date: Wed, 15 Dec 2010 13:41:07 -0800
Subject: [PATCH] msm: rmnet: msm rmnet smd virtual ethernet driver
In-Reply-To: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
References: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
Message-ID: <20101215134107.0354c0c3@nehalam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Dec 2010 10:31:06 -0800
Niranjana Vishwanathapura <nvishwan@codeaurora.org> wrote:

> +static struct net_device_stats *rmnet_get_stats(struct net_device *dev)
> +{
> +	struct rmnet_private *p = netdev_priv(dev);
> +	return &p->stats;
> +}
> +

Just use dev->stats and this function would no longer be needed.

-- 
