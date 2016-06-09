From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 9 Jun 2016 09:43:28 +0200
Subject: [PATCH 05/11] clk: imx: refine the powerup_set bit of clk-pllv3
In-Reply-To: <1465396420-27064-5-git-send-email-aisheng.dong@nxp.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <1465396420-27064-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160609094328.136b7bf8@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 8 Jun 2016 22:33:34 +0800 Dong Aisheng wrote:
> There's a powerdown bit already, so let's change the name of
> powerup_set bit to power_invert to reflects the power polarity
> to make it less confusing.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/imx/clk-pllv3.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index eea2b1b3791e..3fdfb6d2cc71 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -29,8 +29,8 @@
>   * struct clk_pllv3 - IMX PLL clock version 3
>   * @clk_hw:	 clock source
>   * @base:	 base address of PLL registers
> - * @powerup_set: set POWER bit to power up the PLL
> - * @powerdown:   pll powerdown offset bit
> + * @powerdown:	 pll powerdown bit offset
> + * @power_invert: set powerdown bit to power up the PLL
s/set/clear/ ?



Lothar Wa?mann
