From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 Aug 2016 11:26:33 +0100
Subject: [PATCH v2 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <1470045256-9032-3-git-send-email-marc.zyngier@arm.com>
References: <1470045256-9032-1-git-send-email-marc.zyngier@arm.com>
 <1470045256-9032-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <57BAD359.30707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

On 01/08/16 10:54, Marc Zyngier wrote:
> The ARM architected timer specification mandates that the interrupt
> associated with each timer is level triggered (which corresponds to
> the "counter >= comparator" condition).
> 
> A number of DTs are being remarkably creative, declaring the interrupt
> to be edge triggered. A quick look at the TRM for the corresponding ARM
> CPUs clearly shows that this is wrong, and I've corrected those.
> For non-ARM designs (and in the absence of a publicly available TRM),
> I've made them active low as well, which can't be completely wrong
> as the GIC cannot disinguish between level low and level high.
> 
> The respective maintainers are of course welcome to prove me wrong.
> 
> While I was at it, I took the liberty to fix a couple of related issue,
> such as some spurious affinity bits on ThunderX, and their complete
> absence on ls1043a (both of which seem to be related to copy-pasting
> from other DTs).
> 
> Acked-by: Duc Dang <dhdang@apm.com>
> Acked-by: Carlo Caione <carlo@endlessm.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Any update on this patch? We have a workaround merged already, but it'd
be good to have the DTS fixed as well.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
