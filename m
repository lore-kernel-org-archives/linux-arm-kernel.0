From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 23:15:17 +0100
Subject: [PATCH 1/2] arm: samsung: move timer irq numbers to end of
	linux irq space
In-Reply-To: <1317935503-11756-2-git-send-email-thomas.abraham@linaro.org>
References: <1317935503-11756-1-git-send-email-thomas.abraham@linaro.org>
	<1317935503-11756-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111006221517.GC21464@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 02:41:42AM +0530, Thomas Abraham wrote:
> All of Samsung's s5p platforms have timer irqs statically mapped from linux
> irq numbers 11 to 15. These timer irqs are moved to end of the statically
> mapped linux irq space and the hardware irqs, which were statically mapped
> starting from 32 is moved to start from 0. The NR_IRQS macro is consolidated
> for all the s5p platforms in this process.

Am I reading this patch correctly - in that on platforms with the GIC,
you add 32 to the GIC IRQ number _just_ to avoid the possibility that
IRQs 11-15 are seen as valid?

Or to put it another way, you're trying to ensure that if these timer
IRQs are requested, they will fail?
