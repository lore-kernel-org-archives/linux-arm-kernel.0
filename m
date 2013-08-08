From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 08 Aug 2013 12:33:26 +0200
Subject: [PATCH 0/6] ARM: at91: use new at91 clks for samad3 SoCs
In-Reply-To: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
References: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <520373F6.10200@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the noise, I forgot to add the --in-reply-to option.

You'll find the dependencies patch series in attachements.

On 08/08/2013 10:46, Boris BREZILLON wrote:
> Hello,
>
> This patch series was formerly part of the
> "ARM: at91: move to common clk framework" patch series.
>
> It moves sama5d3 SoCs and boards to the new at91 clks (clk implementation
> using common clk framework).
>
> This patch series depends on following patch series (they must be applied in
> this order):
> 1) "ARM: at91/dt: split sama5d3 definition" (v1)
> 2) "ARM: at91/dt: make use of periph id macros" (v2, not submitted yet)
> 3) "ARM: at91: move to common clk framework" (v3)
>
> I will answer to this mail and join this patch series' dependencies in
> attachments.
>
> Best Regards,
>
> Boris
>
> Boris BREZILLON (6):
>    ARM: at91: prepare sama5 dt boards transition to common clk
>    ARM: at91: prepare common clk transition for sama5d3 SoC
>    ARM: at91/dt: define sama5d3 clocks
>    ARM: at91/dt: define sama5d3xek's main clk frequency
>    ARM: at91: move sama5d3 SoC to common clk
>    ARM: at91/dt: remove old main clk definition from sama5d3xcm.dtsi
>
>   arch/arm/boot/dts/sama5d3.dtsi      |  331 ++++++++++++++++++++++++++++++++++-
>   arch/arm/boot/dts/sama5d3_can.dtsi  |   19 ++
>   arch/arm/boot/dts/sama5d3_emac.dtsi |   12 ++
>   arch/arm/boot/dts/sama5d3_gmac.dtsi |   12 ++
>   arch/arm/boot/dts/sama5d3_lcd.dtsi  |   17 ++
>   arch/arm/boot/dts/sama5d3_mci2.dtsi |   11 ++
>   arch/arm/boot/dts/sama5d3_tcb1.dtsi |   12 ++
>   arch/arm/boot/dts/sama5d3_uart.dtsi |   19 ++
>   arch/arm/boot/dts/sama5d3xcm.dtsi   |   17 +-
>   arch/arm/mach-at91/Kconfig          |    1 -
>   arch/arm/mach-at91/board-dt-sama5.c |   10 +-
>   arch/arm/mach-at91/sama5d3.c        |    6 +-
>   12 files changed, 451 insertions(+), 16 deletions(-)
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: dependencies.tgz
Type: application/x-compressed-tar
Size: 47581 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/37b3afbf/attachment-0001.bin>
