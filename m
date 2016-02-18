From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Feb 2016 08:35:43 -0600
Subject: [PATCH v2 2/8] drivers: pinctrl: add driver for Allwinner A64 SoC
In-Reply-To: <1455709440-8668-3-git-send-email-andre.przywara@arm.com>
References: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
 <1455709440-8668-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20160218143543.GC9654@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 11:43:54AM +0000, Andre Przywara wrote:
> Based on the Allwinner A64 user manual and on the previous sunxi
> pinctrl drivers this introduces the pin multiplex assignments for
> the ARMv8 Allwinner A64 SoC.
> Port A is apparently used for the fixed function DRAM controller, so
> the ports start at B here (the manual mentions "n from 1 to 7", so
> not starting at 0).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm64/Kconfig.platforms                       |   1 +
>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c         | 606 +++++++++++++++++++++
>  5 files changed, 613 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
