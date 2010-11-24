From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 24 Nov 2010 21:54:33 +0800
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
Message-ID: <AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 7:13 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> It is a simple driver and there is no need to call its init function
> at the level of a subsystem.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
> ?drivers/spi/pxa2xx_spi.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index e76b1af..6f2f061 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1731,7 +1731,7 @@ static int __init pxa2xx_spi_init(void)
> ?{
> ? ? ? ?return platform_driver_probe(&driver, pxa2xx_spi_probe);
> ?}
> -subsys_initcall(pxa2xx_spi_init);
> +module_init(pxa2xx_spi_init);
>
> ?static void __exit pxa2xx_spi_exit(void)
> ?{
> --

Hi Sebastian,

Actually it's added for cpufreq usage. We can check the commit in below.

commit 5b61a749e8fd0a45a5e37c267d20a43ef0590d68
Author: Antonio Ospite <ospite@studenti.unina.it>
Date:   Tue Sep 22 16:46:10 2009 -0700

    pxa2xx_spi: register earlier

    Register pxa2xx_spi earlier so it can be used with cpufreq

    Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
    Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

So I think that this modifcation may cause others brokne.

Thanks
Haojian
