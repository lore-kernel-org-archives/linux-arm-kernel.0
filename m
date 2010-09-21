From: luciano.coelho@nokia.com (Luciano Coelho)
Date: Tue, 21 Sep 2010 08:36:21 +0300
Subject: [PATCH v6 3/7] wl12xx: add platform data passing support
In-Reply-To: <1284593472-29964-1-git-send-email-ohad@wizery.com>
References: <1284593472-29964-1-git-send-email-ohad@wizery.com>
Message-ID: <1285047381.17849.11.camel@powerslave>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-16 at 01:31 +0200, ext Ohad Ben-Cohen wrote:
> Add a simple mechanism to pass platform data to the
> SDIO instances of wl12xx.
> 
> This way there is no confusion over who owns the 'embedded data',
> typechecking is preserved, and no possibility for the wrong driver to
> pick up the data.
> 
> Originally proposed by Russell King.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---

Acked-by: Luciano Coelho <luciano.coelho@nokia.com>


> diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
> index 5d4ce4d..85af697 100644
> --- a/drivers/net/wireless/Makefile
> +++ b/drivers/net/wireless/Makefile
> @@ -50,5 +50,7 @@ obj-$(CONFIG_ATH_COMMON)	+= ath/
>  obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211_hwsim.o
>  
>  obj-$(CONFIG_WL12XX)	+= wl12xx/
> +# small builtin driver bit
> +obj-$(CONFIG_WL12XX_PLATFORM_DATA)	+= wl12xx/wl12xx_platform_data.o
>  
>  obj-$(CONFIG_IWM)	+= iwmc3200wifi/

I guess this part should be acked by John Linville as well, since it
adds something to the generic wireless driver object.  John?


-- 
Cheers,
Luca.
