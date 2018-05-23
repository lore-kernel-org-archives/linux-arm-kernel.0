From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 May 2018 12:57:00 +0200
Subject: [PATCH v3 03/13] Soc: rockchip: power-domain: add power domain
 support for rk3036
In-Reply-To: <1527058129-10260-4-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
 <1527058129-10260-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <3796690.BWmYtbrbqI@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 23. Mai 2018, 08:48:39 CEST schrieb Elaine Zhang:
> From: Caesar Wang <wxt@rock-chips.com>
> 
> This driver is modified to support RK3036 SoC.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

> @@ -102,6 +103,14 @@ struct rockchip_pmu {
>  	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
>  	.active_wakeup = wakeup,			\
>  }

I've added a blank line here, made "Soc" in the subject lower case and
applied it for 4.18 or 4.19 (not sure yet).


Thanks
Heiko

> +#define DOMAIN_RK3036(req, ack, idle, wakeup)		\
> +{							\
> +	.req_mask = (req >= 0) ? BIT(req) : 0,		\
> +	.req_w_mask = (req >= 0) ?  BIT(req + 16) : 0,	\
> +	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
> +	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
> +	.active_wakeup = wakeup,			\
> +}
