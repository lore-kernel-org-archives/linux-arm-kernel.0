From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 20 Jun 2016 14:48:20 +0200
Subject: [PATCH 07/12] power: pwrseq: rename file name for generic driver
In-Reply-To: <1466158165-9380-8-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-8-git-send-email-peter.chen@nxp.com>
Message-ID: <5767E614.5030002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2016 12:09 PM, Peter Chen wrote:
> The individual driver file name is better to contain module name.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  .../power/pwrseq/{pwrseq-simple.txt => mmc-pwrseq-simple.txt}         | 0
>  drivers/power/pwrseq/Makefile                                         | 4 ++--
>  drivers/power/pwrseq/{pwrseq.c => core.c}                             | 0
>  drivers/power/pwrseq/{pwrseq_simple.c => pwrseq_mmc_simple.c}         | 0
>  4 files changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/power/pwrseq/{pwrseq-simple.txt => mmc-pwrseq-simple.txt} (100%)
>  rename drivers/power/pwrseq/{pwrseq.c => core.c} (100%)
>  rename drivers/power/pwrseq/{pwrseq_simple.c => pwrseq_mmc_simple.c} (100%)
> 
> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt b/Documentation/devicetree/bindings/power/pwrseq/mmc-pwrseq-simple.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
> rename to Documentation/devicetree/bindings/power/pwrseq/mmc-pwrseq-simple.txt
> diff --git a/drivers/power/pwrseq/Makefile b/drivers/power/pwrseq/Makefile
> index 9e40e4b..d475e01 100644
> --- a/drivers/power/pwrseq/Makefile
> +++ b/drivers/power/pwrseq/Makefile
> @@ -1,3 +1,3 @@
> -obj-$(CONFIG_POWER_SEQ)		+= pwrseq.o
> -obj-$(CONFIG_POWER_SEQ_SIMPLE)	+= pwrseq_simple.o
> +obj-$(CONFIG_POWER_SEQ)		+= core.o
> +obj-$(CONFIG_POWER_SEQ_SIMPLE)	+= pwrseq_mmc_simple.o

Although the driver was developed for MMC but it is quite generic (or
rather - mmc independent). The name of the driver is just
"pwrseq_simple" so I think MMC prefix is not needed.

Best regards,
Krzysztof
