From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 7 Nov 2015 23:08:47 -0600
Subject: [PATCH V3 2/4] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <1446958380-23298-3-git-send-email-okaya@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-3-git-send-email-okaya@codeaurora.org>
Message-ID: <563ED8DF.6090307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
> +	val = val & ~(MAX_BUS_REQ_LEN_MASK << MAX_BUS_WR_REQ_BIT_POS);
> +	val = val | (mgmtdev->max_write_request << MAX_BUS_WR_REQ_BIT_POS);
> +	val = val & ~(MAX_BUS_REQ_LEN_MASK);
> +	val = val | (mgmtdev->max_read_request);

val &= ~MAX_BUS_REQ_LEN_MASK << MAX_BUS_WR_REQ_BIT_POS;
val |= mgmtdev->max_write_request << MAX_BUS_WR_REQ_BIT_POS;
val &= ~MAX_BUS_REQ_LEN_MASK;
val |= mgmtdev->max_read_request;

> +static const struct of_device_id hidma_mgmt_match[] = {
> +	{ .compatible = "qcom,hidma-mgmt", },
> +	{ .compatible = "qcom,hidma-mgmt-1.0", },
> +	{ .compatible = "qcom,hidma-mgmt-1.1", },
> +	{},
> +};

I thought Rob said that he did NOT want to use version numbers in 
compatible strings.  And what's the difference between these three 
versions anyway?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
