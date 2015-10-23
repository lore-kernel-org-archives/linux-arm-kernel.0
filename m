From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 22 Oct 2015 23:39:46 -0700
Subject: [PATCH 06/19] input: tegra-kbc: enable support for the standard
 "wakeup-source" property
In-Reply-To: <1445422216-29375-7-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-7-git-send-email-sudeep.holla@arm.com>
Message-ID: <20151023063946.GA38047@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 11:10:03AM +0100, Sudeep Holla wrote:
> Though the mmc core driver should/will continue to support the legacy
> "nvidia,wakeup-source" property to enable SDIO as the wakeup source, we
> need to add support for the new standard property "wakeup-source".
> 
> This patch adds support for "wakeup-source" property in addition to the
> existing "nvidia,wakeup-source" property.
> 
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-input at vger.kernel.org
> Cc: linux-tegra at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/tegra-kbc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index f97c73bd14f8..f80c72d4ac8f 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -517,7 +517,8 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
>  	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
>  		kbc->use_ghost_filter = true;
>  
> -	if (of_find_property(np, "nvidia,wakeup-source", NULL))
> +	if (of_property_read_bool(np, "wakeup-source") ||
> +	    of_property_read_bool(np, "nvidia,wakeup-source")) /* legacy */
>  		kbc->wakeup = true;
>  
>  	if (!of_get_property(np, "nvidia,kbc-row-pins", &proplen)) {
> -- 
> 1.9.1
> 

-- 
Dmitry
