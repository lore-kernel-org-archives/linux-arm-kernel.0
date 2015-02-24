From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Feb 2015 09:15:46 -0800
Subject: [PATCH 0/2] fix ehrpwm tbclk data on am33xx and am43xx
In-Reply-To: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
References: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
Message-ID: <20150224171546.GB28244@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [150209 22:43]:
> In am33xx and am43xx, ehrpwm tbclk is derived from functional clock of
> PWMSS. The schematics and TRMs show that there is only one input clock to
> the PWMSS. But currently, tbclk is wrongly shown to be deriving from
> dpll_per_m2_ck instead of functional clock l4ls_gclk in the DT.
> 
> Fixing ehrpwm tbclk data to reflect the right clk source.
> Tested on beaglebone and am437x-gp-evm.
> 
> Vignesh R (2):
>   ARM: dts: am33xx-clocks: Fix ehrpwm tbclk data on am33xx
>   ARM: dts: am43xx-clocks: Fix ehrpwm tbclk data on am43xx
> 
>  arch/arm/boot/dts/am33xx-clocks.dtsi |  6 +++---
>  arch/arm/boot/dts/am43xx-clocks.dtsi | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Tero, care to check this one too and ack if OK?

Thanks,

Tony
