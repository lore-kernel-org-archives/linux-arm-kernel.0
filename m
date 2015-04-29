From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Apr 2015 12:00:36 -0500
Subject: [PATCH v7 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1430259045-19012-5-git-send-email-lho@apm.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <1430259045-19012-5-git-send-email-lho@apm.com>
Message-ID: <CAL_JsqLTnArXr0K=B-2muNf9hHNzFE7XDMv7Oa+Py6Rj2WUD=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 5:10 PM, Loc Ho <lho@apm.com> wrote:
> This patch adds support for the APM X-Gene SoC EDAC driver.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/edac/Kconfig      |    9 +-
>  drivers/edac/Makefile     |    1 +
>  drivers/edac/xgene_edac.c | 2175 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2184 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/edac/xgene_edac.c
>
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index cb59619..6289dd9 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -10,7 +10,7 @@ config EDAC_SUPPORT
>  menuconfig EDAC
>         bool "EDAC (Error Detection And Correction) reporting"
>         depends on HAS_IOMEM
> -       depends on X86 || PPC || TILE || ARM || EDAC_SUPPORT
> +       depends on X86 || PPC || TILE || ARM || ARM64 || EDAC_SUPPORT

ARM64 selects EDAC_SUPPORT, so you don't need this.

Rob
