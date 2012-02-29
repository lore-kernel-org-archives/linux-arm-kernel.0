From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 29 Feb 2012 14:22:27 +0400
Subject: [PATCH v2 1/7] ARM: davinci, intc: Add OF support for TI interrupt
 controller
In-Reply-To: <4F4DC8EB.7010201@denx.de>
References: <1329893410-24413-1-git-send-email-hs@denx.de>
 <1329893410-24413-2-git-send-email-hs@denx.de> <4F44DE24.30606@mvista.com>
 <4F4DC8EB.7010201@denx.de>
Message-ID: <4F4DFC63.9060509@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 29-02-2012 10:42, Heiko Schocher wrote:

>>> Add a function to initialize the davinci interrupt controller (INTC)
>>> using a device tree node.

>>     cp_intc is not DaVinci interrupt controller, it's only used in
>> OMAP-L1x SoCs. cp_intc stands for Common Platform Interrupt Controller.

> Ah, Ok! Thanks for the explanation.

>> I don't see where you are initializiing the DaVinci interrupt controller
>> itself. You should understand that there are two disctinct types of
>> interrupt controllers used in the SoCs supported by arch/arm/mach-davinci/.

> board code:

> MACHINE_START(ENBW_CMC, "EnBW CMC")
> [...]
>          .init_irq       = davinci_init_irq,

> and in arch/arm/mach-davinci/cp_intc.c

> for the of case:

> void __init davinci_init_irq(void)
> {
>          of_irq_init(irq_match);
> }

> in drivers/of/irq.c:

> /**
>   * of_irq_init - Scan and init matching interrupt controllers in DT
>   * @matches: 0 terminated array of nodes to match and init function to call
>   *
>   * This function scans the device tree for matching interrupt controller nodes,
>   * and calls their initialization functions in order with parents first.
>   */
> void __init of_irq_init(const struct of_device_id *matches)

> Ok, the name of davinci_init_irq() is missleading ...

> Should I name it "cp_intc_of_init" ?

    Probably. At least something with "cp_intc" in the name...

> bye,
> Heiko

WBR, Sergei
