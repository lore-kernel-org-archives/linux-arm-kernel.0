From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 Oct 2014 14:07:31 +0200
Subject: [PATCH 5/7] ARM: mvebu: Enable Performance Monitor Unit on
 Armada 375 SoC
In-Reply-To: <5448EBBF.2060000@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022140421.GL22642@leverpostej>
 <54482CCA.9010002@free-electrons.com>
 <20141023111411.0d4c4a11@free-electrons.com>
 <5448EBBF.2060000@free-electrons.com>
Message-ID: <20141023140731.5401aac3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu, 23 Oct 2014 08:51:27 -0300, Ezequiel Garcia wrote:

> > On Wed, 22 Oct 2014 19:16:42 -0300, Ezequiel Garcia wrote:
> > 
> >> The <mpic 3> is a per CPU interrupt.
> >>
> >> Actually, the interrupt contains more than just PMU events, it contains
> >> a summary of several CPU events: Perf counters for each CPU, Power
> >> management interrupts for each CPU, L2 cache interrupt, among others.
> > 
> > This is kind of a side discussion but if this <mpic 3> interrupts does
> > much more than PMU events, then we should implement a separate irqchip
> > driver for this, to "demultiplex" the events notified by this interrupt.
> 
> Oh, I didn't realize this was possible.

The only trick is that it can't be a separate DT node, because the
registers that contains the mask/cause informations for the events
notified by <mpic 3> belongs to the MPIC registers area.

Not sure how to handle that, maybe Mark will have some suggestions.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
