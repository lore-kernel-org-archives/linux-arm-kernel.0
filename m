From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 07 Jan 2016 11:05:06 +0100
Subject: [PATCH v2 04/12] clk: rockchip: rk3036: enable the
 CLK_IGNORE_UNUSED flag for sclk_i2s_out
In-Reply-To: <1452155155-16232-5-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
 <1452155155-16232-5-git-send-email-wxt@rock-chips.com>
Message-ID: <290434099.8XFZ9qmNRz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Donnerstag, 7. Januar 2016, 16:25:47 schrieb Caesar Wang:
> SCLk_I2S_OUT is the noc bus clock for i2s module, this clock is used by
> extra codecs.
> 
> Due to it shouldn't belong to any driver, but we need it enabled,
> so just mark it as the CLK_IGNORE_UNUSED flag.

What makes you think it shouldn't belong to any driver?

In most schematics I have, i2s_clkout is going to some clock-input of the 
audio codec - probably the MCLK input on your rt5616. And while the new 
rt5616 driver does not seem to do clock handling, it should just handle the 
clock using the normal APIs.


Heiko
