From: david.wu@rock-chips.com (David.Wu)
Date: Mon, 14 Aug 2017 10:46:54 +0800
Subject: [PATCH v3 0/7] Add rk3328 pwm support
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <7e5a11c1-5f1d-9dff-435f-2624d95e16a3@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris && thierry,

Do you have any other suggestion for the patches?

? 2017/8/8 23:38, David Wu ??:
> There are two features of rk3328 pwm module.
>   - PWM APB and function clocks are different.
>   - Add pwm atomic hardware update
> 
> David Wu (7):
>    pwm: rockchip: Add APB and function both clocks support
>    pwm: rockchip: Remove the judge from return value of pwm_config
>    pwm: rockchip: Use pwm_apply instead of the pwm_enable
>    pwm: rockchip: Move the configuration of polarity from
>      rockchip_pwm_set_enable() to rockchip_pwm_config()
>    pwm: rockchip: Use same pwm ops for each IP
>    pwm: rockchip: Add rk3328 pwm support
>    arm64: dts: rockchip: Add pwm nodes for rk3328
> 
>   .../devicetree/bindings/pwm/pwm-rockchip.txt       |   8 +-
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 ++++
>   drivers/pwm/pwm-rockchip.c                         | 281 +++++++++++----------
>   3 files changed, 199 insertions(+), 135 deletions(-)
> 
