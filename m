From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 27 Oct 2014 20:36:18 +0100
Subject: [PATCH 1/8] regulator: max77802: Remove support for board files
In-Reply-To: <1414422226-10948-2-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <544E9EB2.2010408@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> The driver is used only on Exynos based boards with DTS support.
> Convert the driver to DTS-only version.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/regulator/max77802.c | 44 +++++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/regulator/max77802.c b/drivers/regulator/max77802.c
> index 5839c4509e1f..61d03e9f8acf 100644
> --- a/drivers/regulator/max77802.c
> +++ b/drivers/regulator/max77802.c

The original ChromeOS max77xxx driver supported both DT and platform data
configuration and that's why the max77802 driver was not DT-only.

But I looked at the ChromeOS kernel now and indeed even in that tree there
are no board files using the max77802 platform data so I agree that it
should be removed.

Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
