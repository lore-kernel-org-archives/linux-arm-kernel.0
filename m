From: john@phrozen.org (John Crispin)
Date: Fri, 23 Jun 2017 07:48:28 +0200
Subject: [PATCH v2 0/6] mediatek: pwm driver add MT2712/MT7622 support
In-Reply-To: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
References: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
Message-ID: <f2ddc1ea-ca0d-4375-c2c6-e3f6f35a0834@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/17 07:08, Zhi Mao wrote:
> change in v2:
> 1. add error check for enable colock control flow
> 2. use "goto err_clk(main/top)" coding style, for preparing clk error case
> 3. remove comments inline /*===*/
> 4. move "PWM_CLK_DIV_MAX" modification to its own patch
> 5. move pwm source clock selection to its own patch

Hi,
thanks for updating the series, i will give it a quick test on MT7623 today
     John

> Zhi Mao (6):
>    pwm: kconfig: modify mediatek information
>    pwm: mediatek: fix pwm source clock selection
>    pwm: mediatek: fix clock control issue
>    pwm: bindings: add MT2712/MT7622 information
>    pwm: mediatek: add PWM_CLK_DIV_MAX
>    pwm: mediatek: add MT2712/MT7622 support
>
>   .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
>   drivers/pwm/Kconfig                                |    2 +-
>   drivers/pwm/pwm-mediatek.c                         |  132 ++++++++++++++------
>   3 files changed, 103 insertions(+), 37 deletions(-)
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
