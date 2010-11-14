From: me@felipebalbi.com (Felipe Balbi)
Date: Sun, 14 Nov 2010 09:14:41 -0600
Subject: [PATCH] Fix IGEPv2 second MMC channel power supply
In-Reply-To: <1289734452-31625-1-git-send-email-maz@misterjones.org>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
Message-ID: <14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, 14 Nov 2010 11:34:12 +0000, Marc Zyngier <maz@misterjones.org>
wrote:
> @@ -272,8 +273,8 @@ static struct regulator_init_data igep2_vmmc1 = {
>  					| REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> -	.num_consumer_supplies  = 1,
> -	.consumer_supplies      = &igep2_vmmc1_supply,
> +	.num_consumer_supplies  = 2,

use ARRAY_SIZE(igep2_vmmc1_supplies),

-- 
balbi
