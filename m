From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 19 Feb 2016 09:33:03 +0900
Subject: [PATCH 2/3] thermal: exynos: Use devm_regulator_get_optional() for
 vtmu
In-Reply-To: <1455819551-4666-3-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-3-git-send-email-javier@osg.samsung.com>
Message-ID: <56C662BF.5080903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.02.2016 03:19, Javier Martinez Canillas wrote:
> The Exynos TMU DT binding says that the vtmu-supply is optional but the
> driver uses devm_regulator_get() that creates a dummy regulator if it's
> not defined in the DT. For example the following message is in the log:
> 
> 10060000.tmu supply vtmu not found, using dummy regulator
> 
> Use the optional version of regulator_get() that doesn't create a dummy
> regulator and instead returns a -ENODEV errno code. Since it's expected
> that a regulator may not be defined and the driver will inform about it:
> 
> exynos-tmu 10060000.tmu: Regulator node (vtmu) not found
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
