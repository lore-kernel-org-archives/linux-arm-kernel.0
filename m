From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Sep 2012 11:01:02 +0000
Subject: [PATCH 14/17] mfd: db8500-prcmu: use db8500 legacy services
In-Reply-To: <1346839153-6465-15-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1346839153-6465-15-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <201209051101.02595.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 September 2012, Loic Pallardy wrote:
> This patch exposes db8500 legacy services which are
> now available to support new baseband.
> If different are needed, then services are overloaded.
> This allows to reduce duplicate code between projects.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c | 90 +++++++++++++++++++++++-----------------------
>  drivers/mfd/dbx500-prcmu.h | 71 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 73c98e5..b39441f 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -327,12 +327,12 @@ int db8500_prcmu_set_display_clocks(void)
>         return 0;
>  }
>  
> -static u32 db8500_prcmu_read(unsigned int reg)
> +u32 db8500_prcmu_read(unsigned int reg)
>  {
>         return readl(_PRCMU_BASE + reg);
>  }

If these are common to both db8500 and dbx540, why not put the definitions
into the common dbx500.c file, rather than making dbx540 depend on the
db8500?

	Arnd
