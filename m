From: davem@davemloft.net (David Miller)
Date: Mon, 17 Apr 2017 15:20:53 -0400 (EDT)
Subject: [PATCH net-next] drivers: net: xgene-v2: Extend ethtool statistics
In-Reply-To: <1492213698-27813-1-git-send-email-isubramanian@apm.com>
References: <1492213698-27813-1-git-send-email-isubramanian@apm.com>
Message-ID: <20170417.152053.19747385045166399.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Fri, 14 Apr 2017 16:48:18 -0700

> +	XGE_EXTD_STAT(rx_byte_cntr, RBYT),
> +	XGE_EXTD_STAT(rx_pkt_cntr, RPKT),
> +	XGE_EXTD_STAT(rx_fcs_error_cntr, RFCS),
> +	XGE_EXTD_STAT(rx_multicast_pkt_cntr, RMCA),
> +	XGE_EXTD_STAT(rx_broadcast_pkt_cntr, RBCA),

Do not duplicate statistics already reported via xge_get_stats64().
