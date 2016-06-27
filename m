From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 27 Jun 2016 21:43:58 +0200
Subject: [RESEND PATCH v2 0/4] Add support i2s/spdif/gmac features for
 RK322x SoCs
In-Reply-To: <1466565413-31027-1-git-send-email-zhengxing@rock-chips.com>
References: <1466565413-31027-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <16135166.EFsm9ojsF0@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 22. Juni 2016, 11:16:49 schrieb Xing Zheng:
> Hi,
>   We have the brother chipset product that RK3228 and RK3229,
> They have many common configuration, but there are a number
> of different features. In order to develop the future when they
> are easy to distinguish, we need them to be independent.
>   And, these patchset add i2s/gmac dts nodes for RK322x SoCs,
> and add the new dts file of the rk3229 evb board.

applied to my dts32 branch for 4.8 with the following changes

> Xing Zheng (4):
>   ARM: dts: rockchip: rename rk3228.dtsi to rk322x.dtsi

we'll refrain from adding empty rk3228.dtsi files until we have actual things 
to fill it with.

>   ARM: dts: rockchip: add i2s nodes for RK322x SoCs

moved i2s node to correct position according to register map

>   ARM: dts: rockchip: add GMAC nodes for RK322x SoCs

dropped phy-mode and pinctrl settings, as rgmii <-> rmii is a per-board 
thing

>   ARM: dts: rockchip: add support rk3229 evb board

again dropped the empty rk3229.dtsi, we can add that once there are 
additions not shared between rk3228/rk3229.


Heiko
