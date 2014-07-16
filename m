From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Jul 2014 10:21:13 -0700
Subject: [PATCH] PM / devfreq: Allocate memory using the right data type
In-Reply-To: <1405480243-25915-1-git-send-email-skannan@codeaurora.org>
References: <1405480243-25915-1-git-send-email-skannan@codeaurora.org>
Message-ID: <53C6B489.3040001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/14 20:10, Saravana Kannan wrote:
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 65eed38..349e28ea 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -483,9 +483,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  						devfreq->profile->max_state *
>  						devfreq->profile->max_state,
>  						GFP_KERNEL);
> -	devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned int) *
> -						devfreq->profile->max_state,
> -						GFP_KERNEL);
> +	devfreq->time_in_state = devm_kzalloc(dev,
> +					sizeof(*(devfreq->time_in_state)) *
> +					devfreq->profile->max_state,
> +					GFP_KERNEL);

We could use devm_kcalloc() here too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
