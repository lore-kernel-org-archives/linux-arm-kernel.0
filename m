From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Jun 2015 22:19:11 +0200
Subject: [PATCH 01/10] arm/arm64: KVM: Fix ordering of timer/GIC on guest
 entry
In-Reply-To: <1433783045-8002-2-git-send-email-marc.zyngier@arm.com>
References: <1433783045-8002-1-git-send-email-marc.zyngier@arm.com>
 <1433783045-8002-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150630201911.GY11332@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 06:03:56PM +0100, Marc Zyngier wrote:
> As we now inject the timer interrupt when we're about to enter
> the guest, it makes a lot more sense to make sure this happens
> before the vgic code queues the pending interrupts.
> 
> Otherwise, we get the interrupt on the following exit, which is
> not great for latency (and leads to all kind of bizarre issues
> when using with active interrupts at the HW level).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
