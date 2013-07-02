From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Jul 2013 18:31:13 +0300
Subject: [PATCH v2 4/9] wl12xx: use frequency instead of enumerations for
 pdata clocks
In-Reply-To: <1372776948-24840-5-git-send-email-coelho@ti.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-5-git-send-email-coelho@ti.com>
Message-ID: <20130702153113.GF7013@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 02, 2013 at 05:55:43PM +0300, Luciano Coelho wrote:
> diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless/ti/wl12xx/main.c
> index 1c627da..903dcb3 100644
> --- a/drivers/net/wireless/ti/wl12xx/main.c
> +++ b/drivers/net/wireless/ti/wl12xx/main.c
> @@ -1701,6 +1701,42 @@ static struct ieee80211_sta_ht_cap wl12xx_ht_cap = {
>  		},
>  };
>  
> +static struct wl12xx_clock wl12xx_refclock_table[] = {

const

> +	{ 19200000,	false,	WL12XX_REFCLOCK_19	},
> +	{ 26000000,	false,	WL12XX_REFCLOCK_26	},
> +	{ 26000000,	true,	WL12XX_REFCLOCK_26_XTAL	},
> +	{ 38400000,	false,	WL12XX_REFCLOCK_38	},
> +	{ 38400000,	true,	WL12XX_REFCLOCK_38_XTAL	},
> +	{ 52000000,	false,	WL12XX_REFCLOCK_52	},
> +	{ 0,		false,	0 }
> +};
> +
> +static struct wl12xx_clock wl12xx_tcxoclock_table[] = {

const

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/38e6d799/attachment.sig>
