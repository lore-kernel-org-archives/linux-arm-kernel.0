From: liu.y.victor@gmail.com (Liu Ying)
Date: Mon, 31 Dec 2012 14:49:22 +0800
Subject: [PATCH 1/3] Input: imx_keypad - Add device tree support
In-Reply-To: <20121231012455.GD31816@S2101-09.ap.freescale.net>
References: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
 <20121231012455.GD31816@S2101-09.ap.freescale.net>
Message-ID: <CA+8Hj81w_1x2Sm=MyRwzQtSQwbmHqCQfY=cUvgtejgA7WduULw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, I will implement 'compatible' in the usual way.
I checked freescale i.MX21 BSP code, and found that i.MX21 KPP
registers should be compatible with those of later presented SoCs.

2012/12/31 Shawn Guo <shawn.guo@linaro.org>:
> On Sun, Dec 30, 2012 at 09:09:04PM +0800, Liu Ying wrote:
>> +Required SoC Specific Properties:
>> +- compatible: Should be "fsl,imx-kpp".
>
> We generally use SoC name to specify the version of hardware block in
> device tree binding.  In this case, the compatible string should look
> like "fsl,<soc>-kpp" where <soc> is the first IMX chip using this
> block.
>
> For example, if i.MX21 is the first chip integrating the block, and
> i.MX51 just integrates the same block which is completely compatible
> to the one on i.MX21 for software, it should be something like below.
>
> static struct of_device_id imx_keypad_of_match[] = {
>         { .compatible = "fsl,imx21-kpp", },
>         { /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, imx_keypad_of_match);
>
> kpp: kpp at 73f94000 {
>         compatible = "fsl,imx51-kpp", "fsl,imx21-kpp";
>         ...
> };
>
> Shawn
>

Thanks.


-- 
Liu Ying
