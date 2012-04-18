From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 18 Apr 2012 16:08:49 +0400
Subject: [PATCH 09/10] MXS: Enable USB on M28EVK
In-Reply-To: <1334714869-19282-10-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334714869-19282-10-git-send-email-marex@denx.de>
Message-ID: <4F8EAED1.3040307@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-04-2012 6:07, Marek Vasut wrote:

> Enable the second USB port on M28EVK board.

> Signed-off-by: Marek Vasut<marex@denx.de>
> Cc: Chen Peter-B29397<B29397@freescale.com>
> Cc: Detlev Zundel<dzu@denx.de>
> Cc: Fabio Estevam<festevam@gmail.com>
> Cc: Li Frank-B20596<B20596@freescale.com>
> Cc: Lin Tony-B19295<B19295@freescale.com>
> Cc: Linux USB<linux-usb@vger.kernel.org>
> Cc: Sascha Hauer<s.hauer@pengutronix.de>
> Cc: Shawn Guo<shawn.guo@freescale.com>
> Cc: Shawn Guo<shawn.guo@linaro.org>
> Cc: Stefano Babic<sbabic@denx.de>
> Cc: Subodh Nijsure<snijsure@grid-net.com>
> Cc: Tony Lin<tony.lin@freescale.com>
> Cc: Wolfgang Denk<wd@denx.de>
> ---
>   arch/arm/mach-mxs/Kconfig       |    2 ++
>   arch/arm/mach-mxs/mach-m28evk.c |    9 +++++++++
>   2 files changed, 11 insertions(+)

> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 9dbf29f..5b5566c 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
[...]
> @@ -377,6 +382,10 @@ static void __init m28evk_init(void)
>   	mx28_add_ts(&touch_pdata);
>
>   	mx28_add_gpmi_nand(&m28evk_gpmi_nand_data);
> +
> +	gpio_request_one(MXS_GPIO_NR(3, 13), GPIOF_OUT_INIT_LOW, "USB Power");

    Still can fail, and you don't handle it (unlike the next patch).

WBR, Sergei
