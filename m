From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 12 Nov 2015 13:03:11 +0900
Subject: [PATCH v4 2/9] ARM: EXYNOS: Fix potential NULL pointer access in
 exynos_sys_powerdown_conf
In-Reply-To: <1447155784-12667-3-git-send-email-pankaj.dubey@samsung.com>
References: <1447155784-12667-1-git-send-email-pankaj.dubey@samsung.com>
 <1447155784-12667-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56440F7F.6090408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.11.2015 20:42, Pankaj Dubey wrote:
> If no platform devices binded to the driver but driver itself loaded and
> exynos_sys_powerdown_conf is called from
> arch/arm/mach-exynos/{suspend.c, pm.c} it will result in NULL pointer access,
> to prevent this added check on pmu_context for NULL.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/pmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
