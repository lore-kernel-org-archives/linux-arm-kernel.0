From: mylene.josserand@free-electrons.com (Mylene JOSSERAND)
Date: Fri, 8 Dec 2017 23:01:36 +0100
Subject: [PATCH 0/5] sun8i-a83t: Add touchscreen support on TBS A711
In-Reply-To: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Message-ID: <20171208230136.1227eed5@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le Fri,  8 Dec 2017 22:54:14 +0100,
Myl?ne Josserand <mylene.josserand@free-electrons.com> a ?crit :

> Hello everyone,
> 
> This patch series adds touchscreen support (FocalTech EDT-FT5x06
> Polytouch) for TBS A711 (Allwinner sun8i-a83t SoC).
> This touchscreen is using i2c so this series adds support of this bus
> on A83T.
> 
> Series information:
>    - Based on last linux-next (next-20171208)
>    - Had dependencies on AXP209 Quentin Schultz's series:
>    https://www.spinics.net/lists/linux-gpio/msg26913.htmlx

I forgot to mention a dependency on Maxime Ripard's patch that
reinstate AXP813 PMIC:
https://patchwork.kernel.org/patch/10077037/

Thanks,

Myl?ne

> 
> Patch 01: Add i2c0 node on a83t device tree.
> Patch 02: Add i2c0 pin group.
> Patch 03: Enable i2c0 on TBS A711.
> Patch 04: Add support for regulator in the FocalTech touchscreen
> driver because A711 tablet is using a regulator to power-up the
> touchscreen. Patch 05: Add the touchscreen node in A711 TBS tablet.
> 
> Thank you in advance for any review.
> Best regards,
> Myl?ne
> 
> Myl?ne Josserand (5):
>   arm: dts: sun8i: a83t: Add I2C0 node
>   arm: dts: sun8i: a83t: Add I2C0 pins group
>   arm: dts: sun8i: a83t: a711: Enable I2C0
>   Input: edt-ft5x06 - Add support for regulator
>   arm: dts: sun8i: a83t: a711: Add touchscreen node
> 
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 18 +++++++++++++++++
>  arch/arm/boot/dts/sun8i-a83t.dtsi         | 16 +++++++++++++++
>  drivers/input/touchscreen/edt-ft5x06.c    | 33
> +++++++++++++++++++++++++++++++ 3 files changed, 67 insertions(+)
> 
