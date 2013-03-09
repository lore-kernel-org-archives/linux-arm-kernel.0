From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 09 Mar 2013 13:26:56 +0400
Subject: [PATCH v8 3/7] ARM: davinci: Add support for configuring
 DA8XX_REMOTEPROC
In-Reply-To: <1362782508-3166-4-git-send-email-rtivy@ti.com>
References: <1362782508-3166-1-git-send-email-rtivy@ti.com>
 <1362782508-3166-4-git-send-email-rtivy@ti.com>
Message-ID: <513B0060.3090501@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-03-2013 2:41, Robert Tivy wrote:

> Also fix REMOTEPROC config to select FW_LOADER (instead of FW_CONFIG).

> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
>   drivers/remoteproc/Kconfig |   26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)

> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 96ce101..21d04f1 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
[...]
> @@ -41,4 +41,28 @@ config STE_MODEM_RPROC
>   	  This can be either built-in or a loadable module.
>   	  If unsure say N.
>
> +config DA8XX_REMOTEPROC
> +	tristate "DA830/OMAPL137 & DA850/OMAPL138 remoteproc support (EXPERIMENTAL)"
> +	depends on ARCH_DAVINCI_DA8XX
> +	select REMOTEPROC
> +	select RPMSG
> +	select CMA
> +	default n
> +	help
> +	  Say y here to support DA830/OMAPL137 & DA850/OMAPL138 remote

    Naming nit: they're OMAP-L13x. Here and above.

WBR, Sergei
