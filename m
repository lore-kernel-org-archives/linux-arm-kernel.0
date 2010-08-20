From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Aug 2010 19:31:29 +0900
Subject: [PATCH] ARM: S5PV210: Update I2C-1 Clock Register Property.
In-Reply-To: <1282199919-32523-1-git-send-email-myungjoo.ham@samsung.com>
References: <1282199919-32523-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <00da01cb4052$dcb20020$96160060$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> CLK_GATE_IP3[8] is RESERVED. The port "I2C_HDMI_DDY" of
> CLK_GATE_IP3[10] is used as another I2C port (but not dedicated to HDMI
> as if it is a general I2C port)
> 
> Therefore, we define the unused I2C-1 (IP3[8] is not used) as another
> I2C there was left undefined but used.
> 

Your patch file is right, but your comment is not.
Because actually, I2C1 is dedicated to I2C_HDMI_DDC...

Anyway, will apply.

> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index af91fef..825b868 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -357,7 +357,7 @@ static struct clk init_clocks_disable[] = {
>  		.id		= 1,
>  		.parent		= &clk_pclk_psys.clk,
>  		.enable		= s5pv210_clk_ip3_ctrl,
> -		.ctrlbit	= (1<<8),
> +		.ctrlbit	= (1 << 10),
>  	}, {
>  		.name		= "i2c",
>  		.id		= 2,
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
