From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 20 May 2016 22:30:30 -0400
Subject: [PATCH] clk: samsung: Suppress unbinding to prevent theoretical
 attacks
In-Reply-To: <1463469974-13340-1-git-send-email-k.kozlowski@samsung.com>
References: <1463469974-13340-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <b71ecdbc-8650-a246-5e53-94eb620737ba@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/17/2016 03:26 AM, Krzysztof Kozlowski wrote:
> Although unbinding a driver requires root privileges but it still might
> be used theoretically in certain attacks (by triggering NULL pointer
> exception or memory corruption if driver does not provide proper remove
> callbacks or core does not handle it).
> 
> Samsung clock drivers are essential for system operation so their
> removal is not expected. More over, the Exynos3250 ISP clock driver does
> not implement remove() driver callback and it is not buildable as
> modules.
> 
> Suppress the unbind interface for Exynos3250 ISP and S3C2410 DCLK clock
> drivers.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
