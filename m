From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 02 Oct 2014 15:38:18 -0700
Subject: [RFC 5/7] soc: qcom: Add Shared Memory Driver
In-Reply-To: <1412037291-16880-6-git-send-email-bjorn.andersson@sonymobile.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-6-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <542DD3DA.1010909@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/14 17:34, Bjorn Andersson wrote:
> +
> +#define GET_RX_CHANNEL_INFO(channel, param) \
> +	(channel->rx_info_word ? \
> +		channel->rx_info_word->param : \
> +		channel->rx_info->param)
> +
> +#define GET_TX_CHANNEL_INFO(channel, param) \
> +	(channel->rx_info_word ? \
> +		channel->tx_info_word->param : \
> +		channel->tx_info->param)
> +
> +#define SET_RX_CHANNEL_INFO(channel, param, value) \
> +	(channel->rx_info_word ? \
> +		(channel->rx_info_word->param = value) : \
> +		(channel->rx_info->param = value))
> +
> +#define SET_TX_CHANNEL_INFO(channel, param, value) \
> +	(channel->rx_info_word ? \

Drive-by review: Should this be tx_info_word? Given that it works I
wonder why not just have a flag indicating if we should use word aligned
read/write vs. byte aligned.

> +		(channel->tx_info_word->param = value) : \
> +		(channel->tx_info->param = value))
> +


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
