From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 26 Jan 2016 09:46:26 +0900
Subject: [PATCH] fbdev: s6e8ax0: avoid unused function warnings
In-Reply-To: <1453734300-1958304-1-git-send-email-arnd@arndb.de>
References: <1453734300-1958304-1-git-send-email-arnd@arndb.de>
Message-ID: <56A6C1E2.7060804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.01.2016 00:04, Arnd Bergmann wrote:
> The s6e8ax0 suspend/resume functions are hidden inside of an #ifdef
> when CONFIG_PM is set to avoid unused function warnings, but they
> call some other functions that nothing else calls, and we get warnings
> about those:
> 
> drivers/video/fbdev/exynos/s6e8ax0.c:449:13: error: 's6e8ax0_sleep_in' defined but not used [-Werror=unused-function]
> drivers/video/fbdev/exynos/s6e8ax0.c:485:13: error: 's6e8ax0_display_off' defined but not used [-Werror=unused-function]
> 
> This marks the PM functions as __maybe_unused so the compiler can
> silently drop them when they are not referenced.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/exynos/s6e8ax0.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
