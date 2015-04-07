From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 07 Apr 2015 11:48:47 +0200
Subject: [PATCH v2 1/2] ARM: EXYNOS: Get current parent clock for power
 domain on/off
In-Reply-To: <1428053635-10855-1-git-send-email-k.kozlowski@samsung.com>
References: <1428053635-10855-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5523A7FF.2030700@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/03/2015 11:33 AM, Krzysztof Kozlowski wrote:
> Using a fixed (by DTS) parent for clocks when turning on the power domain
> may introduce issues in other drivers. For example when such driver
> changes the parent during runtime and expects that he is the only place
> of such change.
> 
> Do not rely on DTS providing the fixed parent for such clocks. Instead
> before switching domain off, grab a current parent of a clock with
> clk_get_parent().
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. Drop "pclk" bindings entirely as suggested by Andrzej Hajda.
>    This was significant change so I did not add Javier's
>    reviewed/tested tags.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

on an Exynos5420 Peach Pit Chromebook:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
