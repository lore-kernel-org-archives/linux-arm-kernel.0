From: david.wu@rock-chips.com (David.Wu)
Date: Wed, 2 Aug 2017 16:46:58 +0800
Subject: [PATCH v2 0/7] Add rk3328 pwm support
In-Reply-To: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <b4c44f20-9246-a47b-2b8d-d124220474f3@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi thierry & boris,

Do you have any other suggestion for the patches?
We hope to make them arrive in Linux-v4.14.

? 2017/7/8 12:03, David Wu ??:
> There are two features of rk3328 pwm module.
>   - PWM APB and function clocks are different.
>   - Add pwm atomic hardware update
> 
> David Wu (7):
>    pwm: rockchip: Add APB and function both clocks support
>    pwm: rockchip: Remove the judge from return value of pwm_config
>    pwm: rockchip: Remove the dumplicate rockchip_pwm_ops ops
>    pwm: rockchip: Use pwm_apply instead of the pwm_enable
>    pwm: rockchip: Move the configuration of polarity from
>      rockchip_pwm_set_enable() to rockchip_pwm_config()
>    pwm: rockchip: Add rk3328 pwm support
>    arm64: dts: rockchip: Add pwm nodes for rk3328
> 
>   .../devicetree/bindings/pwm/pwm-rockchip.txt       |   9 +-
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 ++++
>   drivers/pwm/pwm-rockchip.c                         | 275 ++++++++++++++-------
>   3 files changed, 236 insertions(+), 93 deletions(-)
> 
