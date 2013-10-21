From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 21 Oct 2013 13:41:59 +0200
Subject: [PATCH] spi/s3c64xx: Fix doubled clock disable on suspend
In-Reply-To: <5264F709.2000409@samsung.com>
References: <1382348117-6666-1-git-send-email-k.kozlowski@samsung.com>
 <5264F709.2000409@samsung.com>
Message-ID: <1382355719.8172.0.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-10-21 at 11:42 +0200, Sylwester Nawrocki wrote:
> pm_runtime_{get,put}* must not be called from drivers's system suspend/resume
> callbacks. Please use pm_runtime_suspended() to check device runtime PM status
> in s3c64xx_spi_{suspend,resume} callbacks and handle the clocks appropriately.

Thanks for review, I will send fixed patch.

Best regards,
Krzysztof
