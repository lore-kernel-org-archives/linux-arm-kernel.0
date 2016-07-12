From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jul 2016 09:09:44 +0100
Subject: [PATCH] irqchip/gicv3-its: Enable cacheable attribute
 Read-allocate hints
In-Reply-To: <1468294608-30619-1-git-send-email-shankerd@codeaurora.org>
References: <1468294608-30619-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <5784A5C8.4080103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On 12/07/16 04:36, Shanker Donthineni wrote:
> Read-allocation hints are not enabled for both the GIC-ITS and GICR
> tables. This forces the hardware to always read the table contents
> from an external memory (DDR) which is slow compared to cache memory.
> Most of the tables are often read by hardware. So, it's better to
> enable Read-allocate hints in addition to Write-allocate hints in
> order to improve the GICR_PEND, GICR_PROP, Collection, Device, and
> vCPU tables lookup time.

While I'm not opposed to such a change, I'd like to see some evidence
that this actually makes a difference. Have you measured an improvement
on a particular implementation? If so, could you share your benchmarking
method so that it could be be measured on others as well?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
