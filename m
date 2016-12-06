From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 6 Dec 2016 12:14:59 +0100
Subject: [RFC PATCH 0/3] clk: at91: audio PLL clock
In-Reply-To: <cover.1481021115.git.nicolas.ferre@atmel.com>
References: <cover.1481021115.git.nicolas.ferre@atmel.com>
Message-ID: <d178db55-751a-329f-d083-d97564637382@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/12/2016 ? 11:55, Nicolas Ferre a ?crit :
> This series covers the addition of the Audio PLL clock found on AT91 SoCs like
> the SAMA5D2.
> I also added the use of these clocks by the ClassD audi amplifier in both SoC
> and board DT.
> 
> The Audio PLL is described in the sama5d2 datasheet chapter "29.8 Audio PLL".
> 
> Even if "it works" (!), note that I'm not satisfied with the current code and
> would need some advice from people more accustomed with the CCF and
> particularly composite audio PLL/clocks like these. For example, I do not take
> into account the limits of these clocks (as described in the datasheet) and the
> dependency between the PAD and the PMC child clocks.
> 
> Thanks in advance for your inputs.

Note as well that Boris already sent me a review of the first posting of
this patch ("[PATCH] clk: at91: add audio pll clock driver" on 31 Jul.
2015) and most of his comments are still relevant.

https://patchwork.kernel.org/patch/6910111/
https://www.spinics.net/lists/arm-kernel/msg436120.html

But I would like some comments about the whole architecture of these
clocks and how I could rearrange them and maybe use some of the common
facilities of the CCF (composite with gate + fractionnal? + divider?, etc.)

Regards,


> Cyrille Pitchen (2):
>   ARM: dts: at91: sama5d2: add classd nodes
>   ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd
> 
> Nicolas Ferre (1):
>   clk: at91: add audio pll clock driver
> 
>  .../devicetree/bindings/clock/at91-clock.txt       |  10 +
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  16 ++
>  arch/arm/boot/dts/sama5d2.dtsi                     |  39 +++-
>  arch/arm/mach-at91/Kconfig                         |   4 +
>  drivers/clk/at91/Makefile                          |   2 +
>  drivers/clk/at91/clk-audio-pll-pad.c               | 238 +++++++++++++++++++
>  drivers/clk/at91/clk-audio-pll-pmc.c               | 184 +++++++++++++++
>  drivers/clk/at91/clk-audio-pll.c                   | 253 +++++++++++++++++++++
>  include/linux/clk/at91_pmc.h                       |  25 ++
>  9 files changed, 770 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll.c
> 


-- 
Nicolas Ferre
