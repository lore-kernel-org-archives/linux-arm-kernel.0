From: michal.vokac@ysoft.com (=?UTF-8?B?TWljaGFsIFZva8OhxI0=?=)
Date: Mon, 11 Jun 2018 14:36:22 +0200
Subject: [RFC] Configure i.MX6 RGMII pad group control registers from device
 tree
Message-ID: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ahoj,

To configure individual pad's characteristics on i.MX6 SoC a
fsl,pins = <PIN_FUNC_ID CONFIG> property can be used. Is there any convenient
way to configure the pad group control registers?

The issue is that some bits (DDR_SEL and ODT) in the individual RGMII pad
control registers are read-only. To tweak those parameters (signal voltage and
termination resistors) one need to write to the pad group control registers for
the whole RGMII pad group. Namely IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII and
IOMUXC_SW_PAD_CTL_GRP_RGMII_TERM. The group registers in general are not
accessible from the list in arch/arm/boot/dts/imx6dl-pinfunc.h.

I could not find any other way to change the group registers than hacking-in
some lines into the imx6q_init_machine(void) function in
arch/arm/mach-imx/mach-imx6q.c source. As I work towards upstreaming my board
this should be done from my device tree or solved in some universal way.

Any hints will be much appreciated.
Michal
