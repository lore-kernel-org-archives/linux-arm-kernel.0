From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 19:04:23 +0530
Subject: [PATCHv2 07/11] arm: arch_timer: divorce from local_timer api
In-Reply-To: <1357747640-18594-8-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-8-git-send-email-mark.rutland@arm.com>
Message-ID: <50F014DF.7090205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> Currently, the arch_timer driver is tied to the arm port, as it relies
> on code in arch/arm/smp.c to setup and teardown timers as cores are
> hotplugged on and off. The timer is registered through an arm-specific
> registration mechanism, preventing sharing the driver with the arm64
> port.
>
> This patch moves the driver to using a cpu notifier instead, making it
> easier to port.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
This is really a nit idea. I think we should do the same
for ARM gic code.

For the patch,
Acked-by : Santosh Shilimkar<santosh.shilimkar@ti.com>
