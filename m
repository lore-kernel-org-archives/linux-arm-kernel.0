From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 4 Mar 2016 10:50:01 +0000
Subject: [PATCH V3 2/4] net-next: mediatek: add support for MT7623 ethernet
In-Reply-To: <1457035361-57669-3-git-send-email-blogic@openwrt.org>
References: <1457035361-57669-1-git-send-email-blogic@openwrt.org>
 <1457035361-57669-3-git-send-email-blogic@openwrt.org>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D41114A26@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin
> Sent: 03 March 2016 20:03
...
> +/* ugly macro hack to make sure hw_stats and ethtool strings are consistent */
> +#define MTK_STAT_REG_DECLARE		\
> +	_FE(tx_bytes)			\
> +	_FE(tx_packets)			\
> +	_FE(tx_skip)			\
> +	_FE(tx_collisions)		\
> +	_FE(rx_bytes)			\
> +	_FE(rx_packets)			\
> +	_FE(rx_overflow)		\
> +	_FE(rx_fcs_errors)		\
> +	_FE(rx_short_errors)		\
> +	_FE(rx_long_errors)		\
> +	_FE(rx_checksum_errors)		\
> +	_FE(rx_flow_control_packets)

Much better is to replace the first line with:
#define MTK_STAT_REG__DECLARE(_FE)
then the calling code can do:
#define XX(x) #x,
const char *names = {MTK_STAT_REG_DECLARE(XX)};
#undef XX

	David
