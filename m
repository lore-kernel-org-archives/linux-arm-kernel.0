From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 14:05:53 +0100
Subject: [PATCH v5 4/5] ARM: Kirkwood: Fix qnap vendor prefix
In-Reply-To: <1392814154-11284-5-git-send-email-klightspeed@killerwolves.net>
References: <1392814154-11284-1-git-send-email-klightspeed@killerwolves.net>
 <1392814154-11284-5-git-send-email-klightspeed@killerwolves.net>
Message-ID: <20140219130553.GO17984@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
> index a75db7f..d350ece 100644
> --- a/drivers/power/reset/qnap-poweroff.c
> +++ b/drivers/power/reset/qnap-poweroff.c
> @@ -41,7 +41,7 @@ static const struct power_off_cfg synology_power_off_cfg = {
>  };
>  
>  static const struct of_device_id qnap_power_off_of_match_table[] = {
> -	{ .compatible = "qnap,power-off",
> +	{ .compatible = "qnapsz,power-off",
>  	  .data = &qnap_power_off_cfg,
>  	},

Hi Ben

This causes issues for devices using old DT blobs. You need to keep
the old entry as well as supporting the new vendor prefix.

We need to consider, is it worth the hassle of changing the prefix,
since it has been in use for a long time. I think using the stock
ticker is a "rule of thumb" and not a strict requirement.

      Andrew
