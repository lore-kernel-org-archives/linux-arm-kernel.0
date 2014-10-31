From: stephen@networkplumber.org (Stephen Hemminger)
Date: Thu, 30 Oct 2014 19:54:58 -0700
Subject: [PATCH] VNIC: Adding support for Cavium ThunderX network
 controller
In-Reply-To: <20141030165434.GW20170@rric.localhost>
References: <20141030165434.GW20170@rric.localhost>
Message-ID: <20141030195458.2958d88a@urahara>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Oct 2014 17:54:34 +0100
Robert Richter <rric@kernel.org> wrote:

> +#ifdef	VNIC_RSS_SUPPORT
> +static int rss_config = RSS_IP_HASH_ENA | RSS_TCP_HASH_ENA | RSS_UDP_HASH_ENA;
> +module_param(rss_config, int, S_IRUGO);
> +MODULE_PARM_DESC(rss_config,
> +		 "RSS hash config [bits 8:0] (Bit0:L2 extended, 1:IP, 2:TCP, 3:TCP SYN, 4:UDP, 5:L4 extended, 6:ROCE 7:L3 bi-directional, 8:L4 bi-directional)");
> +#endif

This should managed  be via ethtool ETHTOOL_GRXFH rather than a module parameter.
