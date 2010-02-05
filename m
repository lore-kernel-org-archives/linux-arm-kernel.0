From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Feb 2010 22:10:09 +0000
Subject: [PATCH 01/06] ARM: SuperH Mobile ARM, sh7367 and G3EVM support V2
In-Reply-To: <20100205111449.17065.11983.sendpatchset@rxone.opensource.se>
References: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
	<20100205111449.17065.11983.sendpatchset@rxone.opensource.se>
Message-ID: <20100205221009.GA1923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2010 at 08:14:49PM +0900, Magnus Damm wrote:
> +	.macro  get_irqnr_preamble, base, tmp
> +	.endm
> +
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm
> +
> +	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +	ldr     \base, =INTFLGA

There's the potential for an optimisation here - move this instruction
into get_irqnr_preamble, and you'll avoid having to re-load the base
register if there's multiple IRQs pending.
