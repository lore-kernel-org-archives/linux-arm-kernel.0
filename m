From: michal.vokac@ysoft.com (=?UTF-8?B?TWljaGFsIFZva8OhxI0=?=)
Date: Tue, 12 Jun 2018 17:09:30 +0200
Subject: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
In-Reply-To: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
Message-ID: <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.6.2018 14:36, Michal Vok?? wrote:
> Ahoj,
> 
> To configure individual pad's characteristics on i.MX6 SoC a
> fsl,pins = <PIN_FUNC_ID CONFIG> property can be used. Is there any convenient
> way to configure the pad group control registers?
> 
> The issue is that some bits (DDR_SEL and ODT) in the individual RGMII pad
> control registers are read-only. To tweak those parameters (signal voltage and
> termination resistors) one need to write to the pad group control registers for
> the whole RGMII pad group. Namely IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII and
> IOMUXC_SW_PAD_CTL_GRP_RGMII_TERM. The group registers in general are not
> accessible from the list in arch/arm/boot/dts/imx6dl-pinfunc.h.
> 
> I could not find any other way to change the group registers than hacking-in
> some lines into the imx6q_init_machine(void) function in
> arch/arm/mach-imx/mach-imx6q.c source. As I work towards upstreaming my board
> this should be done from my device tree or solved in some universal way.
> 
> Any hints will be much appreciated.
> Michal

I figured out this is more "pinctrl-imx.c" than "device-tree" related
so I am kindly adding maintainers of that file in hope somebody will
shed some light to it.

I am diving deeper into the code and it seems there really is no generic
option to set the i.MX6 pad group control registers from device tree.
Or am I looking at the problem from a wrong angle?

How should we deal with boards that need to configure some pad
characteristics available only through the pad group control registers?

I also raised this question at the NXP community forum [1] and get quite
unsatisfying answer so far. I would love to find/implement a proper
and universal solution.

Thanks in advance for your time,
Michal

[1] https://community.nxp.com/thread/477464
