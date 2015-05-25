From: davem@davemloft.net (David Miller)
Date: Mon, 25 May 2015 17:33:48 -0400 (EDT)
Subject: [PATCH net-next v5 2/2] net: Adding support for Cavium
 ThunderX network controller
In-Reply-To: <1432344498-17131-3-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1432344498-17131-1-git-send-email-aleksey.makarov@caviumnetworks.com>
 <1432344498-17131-3-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <20150525.173348.561751759043903433.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
Date: Fri, 22 May 2015 18:28:16 -0700

> +#ifdef NOT_SUPPORTED_FOR_NOW
> +static int nicvf_set_coalesce(struct net_device *netdev,
> +			      struct ethtool_coalesce *cmd)
> +{
 ...
> +#ifdef NOT_SUPPORTED_FOR_NOW
> +	.set_coalesce		= nicvf_set_coalesce,
> +#endif
> +	.get_ringparam		= nicvf_get_ringparam,

Remove this completely.  When you actually make it work and want to
enable it, you can re-add the code.

The upstream kernel is not your personal workspace :-)

> +#ifdef VNIC_RSS_SUPPORT

This is unconditionally defined in one of your headers, please remove
these ifdefs as they will never be false.

> +#ifdef VNIC_RSS_SUPPORT

Likewise.
