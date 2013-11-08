From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 8 Nov 2013 10:13:19 -0600
Subject: [PATCH v3 7/9] ARM: add Armada 1500 and Sony NSZ-GS7 device tree
 files
In-Reply-To: <1383661723-17956-8-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-8-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <0AF697FD-60AA-4B8B-A35F-3DF2FFBCF7AF@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Nov 5, 2013, at 8:28 AM, Sebastian Hesselbarth wrote:

> This adds very basic device tree files for the Marvell Armada 1500 SoC
> (Berlin BG2) and the Sony NSZ-GS7 GoogleTV board. Currently, SoC only has
> nodes for cpus, some clocks, l2 cache controller, local timer, apb timers,
> uart, and interrupt controllers. The Sony NSZ-GS7 is a GoogleTV consumer
> device comprising the Armada 1500 SoC above.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reviewed-by: Jason Cooper <jason@lakedaemon.net>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Changelog:
> v1->v2:
> - add "arm,pl310-cache" compatible to l2cc (Suggested by Mark Rutland)
> - replace 88DE3xxx numbering with SoC variant name
>  (Requested by Jisheng Zhang)
> RCFv2->v1:
> - switch to (soon to be) correct "marvell,pj4b" cpu compatible
> - reference fixed-clock for uarts instead of hard-coded clock-frequency
> - disable timers except two for clksrc and clkevt
> RFCv1->RFCv2:
> - add binding documentation (Reported by Jason Cooper)
> - change l2cc from aurora to tauros3 (Reported by Thomas Petazzoni)
> - add copyright reference
> - adapt compatibles to mach-berlin instead of mach-mvebu
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Rob Landley <rob@landley.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
> .../devicetree/bindings/arm/marvell,berlin.txt     |   24 +++
> arch/arm/boot/dts/Makefile                         |    2 +
> arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |   29 +++
> arch/arm/boot/dts/berlin2.dtsi                     |  227 ++++++++++++++++++++
> 4 files changed, 282 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.txt
> create mode 100644 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
> create mode 100644 arch/arm/boot/dts/berlin2.dtsi

Haven't we been trying to go away from non-prefixed dts/dtsi?

So should these be something like marvell-berlin2-...

- k


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
