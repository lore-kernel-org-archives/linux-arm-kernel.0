From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 00:10:04 +0200
Subject: [PATCH v4 11/28] ARM: dts: Add Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <20170606005426.26446-12-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-12-afaerber@suse.de>
Message-ID: <3a132688-07d9-cc3f-b4d1-85a95199ec93@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4:
>  * Adopted lower-case timer interrupt-names (Mark)
>  
>  v2 -> v3:
>  * Fixed uart2 reg offset
>  * Enlarged timer reg size
>  * Added 2 Hz timer interrupts, interrupt-names
>  * Disabled CPUs 1-3 for now (cf. later patches)
>  * Added Cortex-A9 SCU, global timer, TWD timer/wdt nodes
>  * Added HOSC clock for timer
>  
>  v1 -> v2:
>  * Reworded subject
>  * Updated ARCH_OWL to ARCH_ACTIONS (Arnd)
>  * Adopted "actions" vendor prefix
>  * Dropped irq.h include
>  * Added memory at 0 node for Guitar SoM
>  * Dropped bogus uart3 clock-frequency
>  * Added device_type for CPU nodes
>  * Fixed UART reg size
>  * Adopted SPDX-License-Identifier (Rob)
>  * Added remaining UART nodes
>  * Added timer node
>  
>  arch/arm/boot/dts/Makefile                 |   2 +
>  arch/arm/boot/dts/s500-guitar-bb-rev-b.dts |  26 +++++
>  arch/arm/boot/dts/s500-guitar.dtsi         |  22 ++++
>  arch/arm/boot/dts/s500.dtsi                | 176 +++++++++++++++++++++++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
>  create mode 100644 arch/arm/boot/dts/s500-guitar.dtsi
>  create mode 100644 arch/arm/boot/dts/s500.dtsi

Following a previous discussion with Thomas (that Actions unfortunately
didn't follow-up to with replies here...), I am planning to respin with
s500*.dts[i] renamed to owl-s500*. That will avoid name clashes and will
future-proof the file pattern in MAINTAINERS.

For S900 I don't think we need owl-, as we have actions/* there.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
