From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 1 Sep 2016 12:21:54 +0200
Subject: [PATCH 2/2] ARM: dts: exynos: Fix mismatched values of SD drive
 strengh configuration on exynos4415
In-Reply-To: <1472719022-27226-2-git-send-email-k.kozlowski@samsung.com>
References: <1472719022-27226-1-git-send-email-k.kozlowski@samsung.com>
 <1472719022-27226-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <c8d20e28-bac5-77e1-afd8-3e4860d09f5f@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/01/2016 10:37 AM, Krzysztof Kozlowski wrote:
> The pinctrl drive strength register on exynos4415 is 2-bit wide for each
> pin.  The pins for SD2 were configured with value of 4.  The driver does
> not validate the value so this overflow effectively set a bit 1 in
> adjacent pins thus configuring them to drive strength 2x.
> 
> The author's intention was probably to set drive strength of 4x.
> All other SD pins are configured with drive strength of 4x.  Fix these
> with same pattern.
> 
> Fixes: 9246e7ff24c5 ("ARM: dts: Add dts files for exynos4415 SoC")
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
