From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 15 Jun 2015 17:00:19 +0200
Subject: [PATCH v15 3/4] soc: rockchip: power-domain: add power domain
 driver
In-Reply-To: <1434258820-26779-4-git-send-email-wxt@rock-chips.com>
References: <1434258820-26779-1-git-send-email-wxt@rock-chips.com>
 <1434258820-26779-4-git-send-email-wxt@rock-chips.com>
Message-ID: <1434380419.2069.38.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-06-14 at 13:13 +0800, Caesar Wang wrote:

> --- /dev/null
> +++ b/drivers/soc/rockchip/Kconfig

> +config PM_GENERIC_DOMAINS
> +        tristate "Rockchip generic power domain"

Since my remarks on v13 you removed the module specific code from 
pm_domains.c. But now this became a tristate symbol. That makes little
sense. Why didn't you keep bool?

> +        depends on PM
> +        help
> +          Say y here to enable power doamin support.

s/doamin/domain/.

> +          In order to meet high performance and low power requirements, a power
> +          management unit is designed or saving power when RK3288 in low power
> +          mode. The RK3288 PMU is dedicated for managing the power ot the whole chip.

s/ot/of/

> +          If unsure, say N.

Thanks,


Paul Bolle
