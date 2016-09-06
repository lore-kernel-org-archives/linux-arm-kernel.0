From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 06 Sep 2016 16:08:44 +0200
Subject: [PATCH, RESEND] drm: exynos: avoid unused function warning
In-Reply-To: <20160906133027.2206326-1-arnd@arndb.de>
References: <20160906133027.2206326-1-arnd@arndb.de>
Message-ID: <d20955a1-f7b4-895e-55ce-34784d39e0be@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2016 03:30 PM, Arnd Bergmann wrote:
> When CONFIG_PM is not set, we get a warning about an unused function:
>
> drivers/gpu/drm/exynos/exynos_drm_gsc.c:1219:12: error: 'gsc_clk_ctrl' defined but not used [-Werror=unused-function]
>  static int gsc_clk_ctrl(struct gsc_context *ctx, bool enable)
>             ^~~~~~~~~~~~
>
> This removes the two #ifdef checks in this file and instead marks the
> functions as __maybe_unused, which is a more reliable way of doing the
> same, allowing better build coverage and avoiding the warning above.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
--
Regards
Andrzej
