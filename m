From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 1 Sep 2016 12:19:47 +0200
Subject: [PATCH 1/2] ARM: dts: exynos: Fix mismatched value for SD4 pull
 up/down configuration on exynos4210
In-Reply-To: <1472719022-27226-1-git-send-email-k.kozlowski@samsung.com>
References: <1472719022-27226-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <35fb6718-aa5a-bb72-be3f-a44fab0c5aef@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/01/2016 10:37 AM, Krzysztof Kozlowski wrote:
> The pinctrl pull up/down register on exynos4210 is 2-bit wide for each
> pin and it accepts only values of 0, 1 and 3.  The pins sd4-bus-width8
> were configured with value of 4.  The driver does not validate the value
> so this overflow effectively set a bit 1 in adjacent pins thus
> configuring them to pull down.
> 
> The author's intention was probably to set drive strength of 4x.  All
> other bus-widths pins are configured with pull up and drive strength of
> 4x.  Fix this one with same pattern.
> 
> Fixes: 87711d8c7c70 ("ARM: dts: Add pinctrl node entries for SAMSUNG EXYNOS4210 SoC")
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
