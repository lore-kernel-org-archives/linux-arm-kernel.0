From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Mar 2014 13:19:47 +0100
Subject: [PATCH v2 1/4] clk: samsung: add new Kconfig for Samsung common
 clock options
In-Reply-To: <1394598781-3848-2-git-send-email-pankaj.dubey@samsung.com>
References: <1394598781-3848-1-git-send-email-pankaj.dubey@samsung.com>
 <1394598781-3848-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53298B63.40005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 12.03.2014 05:32, Pankaj Dubey wrote:
> This patch adds new Kconfig file for adding new config option
> as COMMON_CLK_SAMSUNG for Samsung common clock. This patch also
> moves S3C24XX specific clock options here in this file.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   drivers/clk/samsung/Kconfig |   11 +++++++++++
>   1 file changed, 11 insertions(+)
>   create mode 100644 drivers/clk/samsung/Kconfig
>
> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
> new file mode 100644
> index 0000000..26eb446
> --- /dev/null
> +++ b/drivers/clk/samsung/Kconfig
> @@ -0,0 +1,11 @@
> +config COMMON_CLK_SAMSUNG
> +	bool
> +	select COMMON_CLK
> +
> +config S3C2412_COMMON_CLK
> +	bool
> +	select COMMON_CLK_SAMSUNG
> +
> +config S3C2443_COMMON_CLK
> +	bool
> +	select COMMON_CLK_SAMSUNG
>

This patch adds S3C2412_COMMON_CLK and S3C2443_COMMON_CLK to 
drivers/clk/samsung/Kconfig, but they are still present in 
arch/arm/mach-s3c24xx/Kconfig, so after this patch there are duplicate 
definitions.

Best regards,
Tomasz
