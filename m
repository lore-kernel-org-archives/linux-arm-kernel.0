From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 01 Jun 2017 18:50:36 +0900
Subject: [PATCH v2 0/7] Improve ap806 clk support on Marvell Armada 7K/8K
In-Reply-To: <cover.21754b3184e2122d1c83a664477ed26ec562b3e9.1496239589.git-series.gregory.clement@free-electrons.com>
References: <cover.21754b3184e2122d1c83a664477ed26ec562b3e9.1496239589.git-series.gregory.clement@free-electrons.com>
Message-ID: <149631063623.33065.5881396919137461999@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Quoting Gregory CLEMENT (2017-05-31 23:07:21)
> Hi,
> 
> This series modifies the device tree binding of the clock of the AP806
> part that we find in the Marvell Armada 7K/8K SoCs.
> 
> As for the previsous series the only change in this second version is
> about the binding documentation: all the documentation related changes
> are now move in their own patches. It allows to provide a stable -dt
> branch for theses changes. I also added the acked-by from Rob Herring.
> 
> Here again the last two patches modifying the device tree _must_ be
> merged through the mvebu tree to avoid future conflict.

The approach (and the patches) look good to me. I took the DT binding
description changes (patches 2 & 4) into clk-ap806-dt stable branch:

https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-ap806-dt

Anyone can merge the above branch if they need it as a dep.

The driver changes (patches 1, 3 & 5) are merged on into clk-ap806,
which is based on top of clk-ap806-dt:

https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-ap806

Everything has been merged into clk-next. I did not touch the .dts files
at all.

Regards,
Mike

> 
> For the record:
> As for the CP110, we want to be able to ease the integration of new
> clocks without breaking the backward compatibility. It is done in
> patch 3.
> 
> We also want to ease the integration of the pinctrl node in the device
> tree. It is the purpose of the patch 5.
> 
> In this series (as in the previous one for CP110), even if there is
> some change in the device tree binding we paid attention to the
> backward compatibility, and the driver can still work with the old
> device tree.
> 
> Thanks,
> 
> Gregory
> 
> Gregory CLEMENT (7):
>   clk: mvebu: ap806: cosmetic improvement
>   dt-bindings: ap806: do not depend anymore of the *-clock-output-names
>   clk: mvebu: ap806: do not depend anymore of the *-clock-output-names
>   dt-bindings: ap806: introduce a new binding
>   clk: mvebu: ap806: introduce a new binding
>   arm64: dts: marvell: remove clock-output-names on ap806
>   arm64: dts: marvell: use new binding for the system controller on ap806
> 
>  Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt |  24 ++++++++++------
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi                             |  23 +++++++--------
>  drivers/clk/mvebu/ap806-system-controller.c                               | 107 +++++++++++++++++++++++++++++++++++++++++++++++-------------------------
>  3 files changed, 97 insertions(+), 57 deletions(-)
> 
> base-commit: 4139fcd6c66df1c3d3fa0a0a7cf7f8a8c601a16c
> -- 
> git-series 0.9.1
