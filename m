From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 Oct 2014 11:14:11 +0200
Subject: [PATCH 5/7] ARM: mvebu: Enable Performance Monitor Unit on
 Armada 375 SoC
In-Reply-To: <54482CCA.9010002@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022140421.GL22642@leverpostej>
 <54482CCA.9010002@free-electrons.com>
Message-ID: <20141023111411.0d4c4a11@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 22 Oct 2014 19:16:42 -0300, Ezequiel Garcia wrote:

> The <mpic 3> is a per CPU interrupt.
> 
> Actually, the interrupt contains more than just PMU events, it contains
> a summary of several CPU events: Perf counters for each CPU, Power
> management interrupts for each CPU, L2 cache interrupt, among others.

This is kind of a side discussion but if this <mpic 3> interrupts does
much more than PMU events, then we should implement a separate irqchip
driver for this, to "demultiplex" the events notified by this interrupt.

Yes, today we are only using the PMU events from <mpic 3>, but what if
tomorrow we need to be notified of other events in other drivers? We
would be screwed, because we would have to change the DT
representation: the PMU would no longer take <&mpic 3> as the
interrupt, but <&some_other_irq_controller XYZ> as the interrupt.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
