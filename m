From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 24 Jan 2015 18:15:23 +0100 (CET)
Subject: [PATCH v4] irqchip: gic: Allow interrupt level to be set for PPIs.
In-Reply-To: <87mw5bf256.fsf@approximate.cambridge.arm.com>
References: <1421772779-25764-1-git-send-email-Liviu.Dudau@arm.com>
 <87mw5bf256.fsf@approximate.cambridge.arm.com>
Message-ID: <alpine.DEB.2.11.1501241814430.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jan 2015, Marc Zyngier wrote:

> On Tue, Jan 20 2015 at  4:52:59 pm GMT, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > During a recent cleanup of the arm64 DTs it has become clear that
> > the handling of PPIs in xxxx_set_type() is incorrect. The ARM TRMs
> > for GICv2 and later allow for "implementation defined" support for
> > setting the edge or level type of the PPI interrupts and don't restrict
> > the activation level of the signal. Current ARM implementations
> > do restrict the PPI level type to IRQ_TYPE_LEVEL_LOW, but licensees
> > of the IP can decide to shoot themselves in the foot at any time.
> >
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> For the GIC and GICv3 parts:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

So I queue that if there are no further objections from Russell or the
DT folks.

Thanks,

	tglx
