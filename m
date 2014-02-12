From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Feb 2014 11:04:11 -0200
Subject: [PATCH] ARM: imx6: fix !CONFIG_PM and !CONFIG_CPU_IDLE build
In-Reply-To: <1392201948-16311-1-git-send-email-l.stach@pengutronix.de>
References: <1392201948-16311-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAOMZO5DJNBQU1oL+V3r_=WfX8b_Qd_-OVbdnzVj=AMSS8ndhcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 8:45 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -138,7 +138,6 @@ void imx_gpc_irq_unmask(struct irq_data *d);
>  void imx_anatop_init(void);
>  void imx_anatop_pre_suspend(void);
>  void imx_anatop_post_resume(void);
> -int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
>  void imx6q_set_chicken_bit(void);

This function has been renamed since commit f191d820b1b (ARM: imx: Use
INT_MEM_CLK_LPM as the bit name)

Regards,

Fabio Estevam
