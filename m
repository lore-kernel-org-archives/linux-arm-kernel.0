From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 27 Oct 2014 20:48:08 +0100
Subject: [PATCH 3/8] mfd: max77686/802: Remove support for board files
In-Reply-To: <1414422226-10948-4-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <544EA178.3090506@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> The driver is used only on Exynos based boards with DTS support.
> Convert the driver to DTS-only version. This simplifies a little the
> code:
> 1. No dead (unused) entries in platform_data structure.
> 2. More code removed (from all three patches: 34 insertions(+), 107
>    deletions).
> 3. Regulator driver does not depend on allocated memory
>    from MFD driver.
> 4. It makes also easier extending the regulator driver
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/max77686.c               | 23 -----------------------
>  include/linux/mfd/max77686-private.h |  1 -
>  include/linux/mfd/max77686.h         | 22 ----------------------
>  3 files changed, 46 deletions(-)
> 
> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
> index 929795eae9fc..3da237afacde 100644
> --- a/drivers/mfd/max77686.c
> +++ b/drivers/mfd/max77686.c

As I said in Patch 2/8, I think this driver should depend on OF since
is now DT-only. Regulator drivers don't need to do this since they
already depend on MFD_MAX77686. With that change feel free to add:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Please also add my Reviewed-by tag to Patch 2/8 since I just noticed
that I forgot to add it.

Best regards,
Javier
