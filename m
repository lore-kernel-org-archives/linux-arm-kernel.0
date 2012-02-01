From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 1 Feb 2012 13:21:29 +0900
Subject: [PATCH 6/9] serial: samsung: Add support for EXYNOS5250
In-Reply-To: <1328024354-4277-7-git-send-email-kgene.kim@samsung.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAH9JG2XE7nj1je9SYQ=zJKo0_P5Sx_ruZrDjtpnsL0Qtvzb+_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/tty/serial/samsung.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 3b07fb9..c55e5fb 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1594,7 +1594,7 @@ static struct s3c24xx_serial_drv_data
> s5pv210_serial_drv_data = {
>  #endif
>
>  #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
> -	defined(CONFIG_SOC_EXYNOS4412)
> +	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
I think you can make it simple just use "#ifdef CONFIG_ARCH_EXYNOS "
>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>  	.info = &(struct s3c24xx_uart_info) {
>  		.name		= "Samsung Exynos4 UART",
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
