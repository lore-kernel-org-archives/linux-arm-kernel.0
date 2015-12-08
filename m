From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 8 Dec 2015 11:54:11 +0100 (CET)
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <20151208095835.582dc34b@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
 <20151111092638.587a53a4@free-electrons.com>
 <alpine.DEB.2.11.1511131509180.3987@nanos>
 <20151204120329.30a52cf4@free-electrons.com>
 <alpine.DEB.2.11.1512051823140.3595@nanos>
 <alpine.DEB.2.11.1512061018450.3595@nanos>
 <20151208095835.582dc34b@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1512081153410.3595@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Dec 2015, Thomas Petazzoni wrote:
> When a device driver uses a normal (non per-CPU) interrupt, then it
> doesn't have to take care of disabling the interrupt on suspend and
> re-enabling the interrupt on resume at the interrupt controller level.
> This is all transparently handled by the irqchip driver.
> 
> Why should the handling of per-CPU interrupts be different and require
> explicit handling from each device driver rather than being
> transparently handled by the irqchip driver ?

Fair enough. Did not think about the boot cpu part.

Thanks,

	tglx
