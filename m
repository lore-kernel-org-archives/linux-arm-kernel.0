From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 7 Dec 2016 20:43:32 +0100
Subject: [RFC PATCH net-next v3 2/2] macb: Enable 1588 support in SAMA5Dx
 platforms.
In-Reply-To: <1481134912-2243-2-git-send-email-andrei.pistirica@microchip.com>
References: <1481134912-2243-1-git-send-email-andrei.pistirica@microchip.com>
 <1481134912-2243-2-git-send-email-andrei.pistirica@microchip.com>
Message-ID: <20161207194332.GB13062@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 08:21:52PM +0200, Andrei Pistirica wrote:
> +static int gem_hwtst_set(struct net_device *netdev,
> +			 struct ifreq *ifr, int cmd)
> +{

...

> +	switch (config.rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		if (priv->hwts_rx_en)
> +			priv->hwts_rx_en = 0;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_ALL:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +		config.rx_filter = HWTSTAMP_FILTER_ALL;

Does the device really time stamp all packets?

Or did you mean "all PTP packets?  For that, use
HWTSTAMP_FILTER_PTP_V2_EVENT.

Thanks,
Richard
