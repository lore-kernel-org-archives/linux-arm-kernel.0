From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 29 Jan 2016 13:37:21 +0200
Subject: [PATCH] fbdev: s6e8ax0: avoid unused function warnings
In-Reply-To: <1453734300-1958304-1-git-send-email-arnd@arndb.de>
References: <1453734300-1958304-1-git-send-email-arnd@arndb.de>
Message-ID: <56AB4EF1.3090404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/16 17:04, Arnd Bergmann wrote:
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

Thanks, queued for 4.5 fixes.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/476f5a46/attachment.sig>
