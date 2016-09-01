From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 1 Sep 2016 21:02:23 +0100
Subject: [PATCH v4 0/3] nvmem: rockchip-efuse: support more rockchip SoCs
In-Reply-To: <1472464210-30252-1-git-send-email-finley.xiao@rock-chips.com>
References: <1472464210-30252-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <f9c6e53e-ae5f-d67a-3464-e10a3dee808c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Finley,


On 29/08/16 10:50, Finley Xiao wrote:
> As the timing and organization of efuse may be different
> between rockchip SoCs, so their read function may be different.
> We add different device tree compatible string for rockchip SoCs
> to match their own read function.
>
> V3->V4:
> - 3/3 change the type of out_value into u32 and buf into u8, their values
>   come from register, use u32 and u8 may be more readable.
>
> Finley Xiao (3):
>   nvmem: rockchip-efuse: update compatible strings for Rockchip efuse
>   ARM: dts: rockchip: update compatible strings for Rockchip efuse
>   nvmem: rockchip-efuse: add rk3399-efuse support
>
I can take patch 1 and 3, but dts has to go via arm soc tree.

thanks,
srini
>  .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  13 +-
>  arch/arm/boot/dts/rk3066a.dtsi                     |   2 +-
>  arch/arm/boot/dts/rk3188.dtsi                      |   2 +-
>  arch/arm/boot/dts/rk3288.dtsi                      |   2 +-
>  drivers/nvmem/rockchip-efuse.c                     | 131 ++++++++++++++++++---
>  5 files changed, 126 insertions(+), 24 deletions(-)
>
