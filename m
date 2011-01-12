From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 12 Jan 2011 15:17:04 +0530
Subject: [RFC] ARM: Let GIC to route IRQs to any allowed CPUs
In-Reply-To: <AANLkTim3BUvnMsH=oW1cxmzT2wmwpxPFLjrP39TGbuhx@mail.gmail.com>
References: <AANLkTimNMcs_6-NMTSY+yZuDUSB2eC2R_NX35gq00f7E@mail.gmail.com><20110112085110.GR11039@n2100.arm.linux.org.uk>
	<AANLkTim3BUvnMsH=oW1cxmzT2wmwpxPFLjrP39TGbuhx@mail.gmail.com>
Message-ID: <68d8f4403d87056247664a4ec82faded@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hu Tao,
(Please avoid top posting)
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of TAO HU
> Sent: Wednesday, January 12, 2011 2:35 PM
> To: Russell King - ARM Linux
> Cc: TAO HU; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC] ARM: Let GIC to route IRQs to any allowed CPUs
>
> Hi, Russell King
>
> Thanks.
>
> For "The result will be CPUs fighting over servicing such
> interrupts."
> What's the consequence? The performance downgrade?
>
Few problems I can see here.
1. Spurious interrupts will be seen by CPU who looses the IRQ race
2. When interrupts are targeted on two CPU's, and if one of the CPU is
in low power mode, the ON CPU will not see the interrupt till the     OFF
CPU becomes ON again.
3. Unnecessary wakeups on both CPUs which can screw up power savings.
4. prone to aggravate race conditions in the existing drivers.

Regards,
Santosh
