From: cjb@laptop.org (Chris Ball)
Date: Tue, 06 Nov 2012 17:14:18 -0500
Subject: [PATCH 5/8] mmc: dw_mmc: fix modular build for exynos back-end
In-Reply-To: <1352238933-4886-6-git-send-email-arnd@arndb.de> (Arnd Bergmann's
 message of "Tue, 6 Nov 2012 22:55:30 +0100")
References: <1352238933-4886-1-git-send-email-arnd@arndb.de>
 <1352238933-4886-6-git-send-email-arnd@arndb.de>
Message-ID: <87liee8jlx.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Nov 06 2012, Arnd Bergmann wrote:
> The MODULE_DEVICE_TABLE entry for dw_mci_exynos_match
> was incorrectly copied from the platform back-end, which
> causes this error when building the driver as a loadable
> module:
>
> drivers/mmc/host/dw_mmc-exynos.c: At top level:
> drivers/mmc/host/dw_mmc-exynos.c:226:34: error: '__mod_of_device_table' aliased to undefined symbol 'dw_mci_pltfm_match'
>
> This patch fixes the problem by just using the correct
> string.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Will Newton <will.newton@imgtec.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 660bbc5..0147ac3a 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -223,7 +223,7 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>  			.data = (void *)&exynos5250_drv_data, },
>  	{},
>  };
> -MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> +MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
>  
>  int dw_mci_exynos_probe(struct platform_device *pdev)
>  {

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
