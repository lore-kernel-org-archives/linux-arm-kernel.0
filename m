From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 5 Aug 2015 12:53:20 +0200
Subject: [PATCH 1/2] mfd: s2mps11: Add manual shutdown method for Odroid
 XU3
In-Reply-To: <1438605447-6836-2-git-send-email-k.kozlowski.k@gmail.com>
References: <1438605447-6836-1-git-send-email-k.kozlowski.k@gmail.com>
 <1438605447-6836-2-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <55C1EB20.3040400@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 08/03/2015 02:37 PM, Krzysztof Kozlowski wrote:
> On Odroid XU3 board (with S2MPS11 PMIC) the PWRHOLD bit in CTRL1
> register must be manually set to 0 before initiating power off sequence.
> 
> One of usual power down methods for Exynos based devices looks like:
> 1. PWRHOLD pin of PMIC is connected to PSHOLD of Exynos.
> 2. Exynos holds up this pin during system operation.
> 3. ACOKB pin of PMIC is pulled up to VBATT and optionally to pin in
>    other device.
> 4. When PWRHOLD/PSHOLD goes low, the PMIC will turn off the power if
>    ACOKB goes high.
> 
> On Odroid XU3 family the difference is in (3) - the ACOKB is grounded.
> This means that PMIC must manually set PWRHOLD field to low and then
> wait for signal from Application Processor (the usual change in
> PWRHOLD/PSHOLD pin will actually cut off the power).
>

Is nice to finally have an explanation about why this is needed.
 
> The patch adds respective binding allowing Odroid XU3 device to be
> powered off.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> Reported-by: Anand Moon <linux.amoon@gmail.com>
> 
> ---
> 
> Patch is losely based on patch in Hardkernel repository [0] and previous
> work of Anand Moon [1].
> 
> [0] https://github.com/hardkernel/linux/commit/6897e62ba328bd1c8c095d918101863250cd73e7
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg45959.html
> ---
>  Documentation/devicetree/bindings/mfd/s2mps11.txt |  4 +++
>  drivers/mfd/sec-core.c                            | 31 +++++++++++++++++++++++
>  include/linux/mfd/samsung/core.h                  |  2 ++
>  include/linux/mfd/samsung/s2mps11.h               |  1 +
>  4 files changed, 38 insertions(+)
>

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
