From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Nov 2014 22:29:58 +0100 (CET)
Subject: [PATCH 3.18-rc3 v8 1/4] irqchip: gic: Make gic_raise_softirq()
 FIQ-safe
In-Reply-To: <54739CA8.2080406@linaro.org>
References: <1415183260-6389-1-git-send-email-daniel.thompson@linaro.org>
 <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1415968543-29469-2-git-send-email-daniel.thompson@linaro.org>
 <alpine.DEB.2.11.1411241918090.6439@nanos>
 <alpine.DEB.2.11.1411241928300.6439@nanos>
 <alpine.DEB.2.11.1411242101130.6439@nanos> <54739CA8.2080406@linaro.org>
Message-ID: <alpine.DEB.2.11.1411242219030.6439@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Nov 2014, Daniel Thompson wrote:
> On 24/11/14 20:38, Thomas Gleixner wrote:
> > So while I cannot come up with a brilliant replacement, it would be
> > really helpful documentation wise if you could do the following:
> > 
> > 1) Create a patch which introduces irq_migration_lock as a raw
> >    spinlock and replaces the usage of irq_controller_lock in
> >    gic_raise_softirq() and gic_migrate_target() along with a proper
> >    explanation in the code and the changelog of course.
> 
> Replace irq_controller_lock or augment it with a new one?

Replace it in gic_raise_softirq() and add it to gic_migrate_target()
as you did with the RW lock.
 
Thanks,

	tglx
