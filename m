From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 6 Jun 2017 12:29:57 +0200 (CEST)
Subject: Design of interrupt controller driver
In-Reply-To: <e0380463-f13f-2ca2-b941-7a40b3b8fc36@free.fr>
References: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
 <alpine.DEB.2.20.1706041551530.2813@nanos>
 <025780ef-06e6-1e85-58da-4ce8f6c93536@free.fr>
 <alpine.DEB.2.20.1706042208080.3517@nanos>
 <6e4da485-42cc-9b70-1b4a-9729f646e014@free.fr>
 <alpine.DEB.2.20.1706051007050.3517@nanos>
 <77a6e423-5c6a-9e5a-d679-c2576074fe6d@free.fr>
 <alpine.DEB.2.20.1706060922220.1885@nanos>
 <e0380463-f13f-2ca2-b941-7a40b3b8fc36@free.fr>
Message-ID: <alpine.DEB.2.20.1706061228430.1885@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Jun 2017, Mason wrote:
> On 06/06/2017 09:39, Thomas Gleixner wrote:
> What about disable_irq(virq);
> That function /is/ exported API, and eventually calls mask_irq.
> 
> disable_irq -> __disable_irq_nosync -> __disable_irq -> irq_disable -> mask_irq

What you can call from an ISR is disable_irq_nosync(). disable_irq() will
deadlock.

Thanks,

	tglx
