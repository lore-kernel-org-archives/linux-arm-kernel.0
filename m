From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 12:15:53 +0100 (CET)
Subject: [RFC PATCH 28/33] irqchip/gic-v3-its: Support VPE doorbell
 invalidation even when !DirectLPI
In-Reply-To: <1484648454-21216-29-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-29-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131214430.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:
> When we don't have the DirectLPI feature, we must work around the
> architecture shortcomings to be able to perform the required
> invalidation.
> 
> For this, we create a fake device whose sole purpose is to
> provide a way to issue a map/inv/unmap sequence (and the corresponding
> sync operations). That's 6 commands and a full serialization point
> to be able to do this.
> 
> You just have hope the hypervisor won't do that too often...
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
