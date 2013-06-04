From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jun 2013 14:19:32 -0400 (EDT)
Subject: [PATCH v2 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <20130604181030.GA18614@n2100.arm.linux.org.uk>
References: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
 <1370354598-12920-2-git-send-email-gregory.clement@free-electrons.com>
 <20130604145958.GY18614@n2100.arm.linux.org.uk>
 <51AE21A7.5080907@free-electrons.com>
 <20130604173737.GZ18614@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1306041348400.1200@syhkavp.arg>
 <20130604181030.GA18614@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1306041412490.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jun 2013, Russell King - ARM Linux wrote:

> On Tue, Jun 04, 2013 at 02:07:29PM -0400, Nicolas Pitre wrote:
> > Alternatively, the following could be done:
> > 
> > #ifdef CONFIG_CPU_PJ4B
> > 
> > 	.equ	cpu_pj4b_switch_mm,	cpu_v7_switch_mm
> > 	.equ	cpu_pj4b_set_pte_ex,	cpu_v7_set_pte_ex
> 
> No, that doesn't work.  I did forget a hunk from my patch though, which
> needs the pj4b symbols to be global:

	.macro globl_equ x, y
	.globl	x
	.equ	x, y
	.endm

	.globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
	.globl_equ	cpu_pj4b_set_pte_ex,	cpu_v7_set_pte_ex
	...


Nicolas
