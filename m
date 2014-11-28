From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 15:32:37 +0000
Subject: [PATCH v2 1/8] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT6397 SoC
In-Reply-To: <1417146874-5232-2-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-2-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141128153237.GU7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 11:54:27AM +0800, Flora Fu wrote:

> +config MT8135_PMIC_WRAP
> +	tristate "MediaTek MT8135 PMIC Wrapper Support"
> +	depends on ARCH_MEDIATEK
> +	help

> +#include <linux/regmap.h>

This uses regmap but doesn't select anything from the regmap framework
so won't build if nothing else selects regmap.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/ead01535/attachment.sig>
