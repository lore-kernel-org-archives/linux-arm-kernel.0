From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 15 Jan 2018 09:55:43 +0100
Subject: [PATCH][next] hwrng: exynos: check for -ve error return from
 readl_poll_timeout
In-Reply-To: <20180112163048.26960-1-colin.king@canonical.com>
References: <20180112163048.26960-1-colin.king@canonical.com>
Message-ID: <CAJKOXPeBJi2eLROVXhPWPpVHvCgAzhhbkmE2yR8fP+oMCUT5Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 5:30 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently, the return from readl_poll_timeout is being assigned to
> a u32 and this is being checked for a -ve return which is always
> false since a u32 cannot be less than zero.  Fix this by changing
> val to an int so that error returns can be correctly detected.
>
> Detected by CoverityScan, CID#1463776 ("Logically dead code")
>
> Fixes: 6cd225cc5d8a ("hwrng: exynos - add Samsung Exynos True RNG driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/char/hw_random/exynos-trng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks for the patch! Dan already fixed this few days before:
https://www.spinics.net/lists/linux-samsung-soc/msg61724.html

Best regards,
Krzysztof
