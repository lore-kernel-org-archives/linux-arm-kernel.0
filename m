From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Nov 2014 21:41:00 +0100 (CET)
Subject: [PATCH 3.18-rc3 v8 1/4] irqchip: gic: Make gic_raise_softirq()
 FIQ-safe
In-Reply-To: <547396D0.5030309@linaro.org>
References: <1415183260-6389-1-git-send-email-daniel.thompson@linaro.org>
 <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1415968543-29469-2-git-send-email-daniel.thompson@linaro.org>
 <alpine.DEB.2.11.1411241918090.6439@nanos>
 <alpine.DEB.2.11.1411241928300.6439@nanos> <547396D0.5030309@linaro.org>
Message-ID: <alpine.DEB.2.11.1411242139240.6439@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Nov 2014, Daniel Thompson wrote:
> I did want to remove the lock too. However when I reviewed this code I
> concluded the lock was still required. Without it I think it is possible
> for gic_raise_softirq() to raise an IPI on the old core *after* the code
> to migrate pending IPIs has been run.

And I bet it took you quite some time to figure that out from that
overly documented abuse of irq_controller_lock. See my other reply.

Thanks,

	tglx
