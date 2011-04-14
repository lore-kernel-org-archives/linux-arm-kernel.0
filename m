From: B02280@freescale.com (Chen Jie-B02280)
Date: Thu, 14 Apr 2011 09:01:37 +0000
Subject: [PATCH 5/7] ARM i.MX53 loco: Add framebuffer support
In-Reply-To: <20110414085714.GY7285@pengutronix.de>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
	<1302710016-3569-5-git-send-email-weitway@gmail.com>
	<20110414085714.GY7285@pengutronix.de>
Message-ID: <33F32152BE7EC740BC2C838D2836AC8710FD9C@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sascha,

I tested this patch on wvga lcd panel for loco board.

You can not get vga output if without tve driver support, I am planning upstream tve driver later.

And how do you test HDMI on loco board? Do you get hdmi daughter card?

Jason Chen / Chen Jie
NMG / MAD
Freescale Semiconductor (China) Ltd.
Shanghai Branch Office
No.192 Liangjing Rd.,
Pu Dong New District Shanghai?201203
Tel:???? 021-28937178?
Fax:???? 021-28937444
E-mail:??Jason.Chen at freescale.com


-----Original Message-----
From: Sascha Hauer [mailto:s.hauer at pengutronix.de] 
Sent: Thursday, April 14, 2011 4:57 PM
To: weitway at gmail.com
Cc: linux-arm-kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de; eric.miao at linaro.org; Chen Jie-B02280; Chen Jie-B02280
Subject: Re: [PATCH 5/7] ARM i.MX53 loco: Add framebuffer support

On Wed, Apr 13, 2011 at 11:53:34PM +0800, weitway at gmail.com wrote:
> From: Jason Chen <b02280@freescale.com>
>
> Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig           |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |   24 ++++++++++++++++++++++++
>  arch/arm/mach-mx5/clock-mx51-mx53.c |    3 +++
>  3 files changed, 28 insertions(+), 0 deletions(-)


Does the driver already work on the LOCO board? I just tested it on my board and get no picture (neither on VGA nor on HDMI).
I got a picture on HDMI with another version of this driver and some hacking in the clock code, but as of now this only works when a freescale kernel is started first and rebooted into my kernel without powercycling.
There is no picture on the VGA output though and I think there is code missing for the TV encoder.

>  }
>  
>  static void __init mx53_loco_timer_init(void) diff --git 
> a/arch/arm/mach-mx5/clock-mx51-mx53.c 
> b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 652ace4..213ec33 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1468,6 +1468,9 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
>  	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
>  	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> +	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
> +	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
> +	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)

This change shouldn't be in this patch of course.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
