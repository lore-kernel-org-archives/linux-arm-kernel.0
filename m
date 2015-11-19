From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 19 Nov 2015 15:08:29 +0800
Subject: [PATCH v3 03/12] drm/rockchip: return a true clock rate to
 adjusted_mode
In-Reply-To: <1447904131-29328-4-git-send-email-zyw@rock-chips.com>
References: <1447904131-29328-1-git-send-email-zyw@rock-chips.com>
 <1447904131-29328-4-git-send-email-zyw@rock-chips.com>
Message-ID: <564D756D.9050000@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?11?19? 11:35, Chris Zhong wrote:
> +
> +	/*
> +	 * Sometimes the clock driver can not set a accurate clock_rate for vop,
> +	 * get the true rate of vop_dclk and set it back to adjusted_mode.
> +	 */
> +	adjusted_mode->clock = clk_get_rate(vop->dclk) / 1000;
>   out:
>   	ret_clk = clk_enable(vop->dclk);
>   	if (ret_clk < 0) {
Hi Chris
      How about use clk_round_rate to check the clock rate first?
      I think we can check it on vop_crtc_mode_fixup.

Thanks.
- ?ark Yao
