From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 17 Apr 2012 21:40:55 +0400
Subject: [PATCH 7/8] MXS: Enable USB on M28EVK
In-Reply-To: <1334657751-27678-8-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334657751-27678-8-git-send-email-marex@denx.de>
Message-ID: <4F8DAB27.90107@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/17/2012 02:15 PM, Marek Vasut wrote:

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
[...]

> @@ -377,6 +382,11 @@ static void __init m28evk_init(void)
>   	mx28_add_ts(&touch_pdata);
>
>   	mx28_add_gpmi_nand(&m28evk_gpmi_nand_data);
> +
> +	gpio_request(MXS_GPIO_NR(3, 13), "USB");

    gpio_request() can fail and you don't handle it.

> +	gpio_direction_output(MXS_GPIO_NR(3, 13), 0);

    You can use gpio_request_one() instead of the above 2 calls.

WBR, Sergei
