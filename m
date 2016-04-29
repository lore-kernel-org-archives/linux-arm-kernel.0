From: rric.net@gmail.com (Robert Richter)
Date: Fri, 29 Apr 2016 15:02:30 +0200
Subject: [RFC PATCH] irqchip/gic-v3-its: Allocate ITS tables from
 corresponding node memory
In-Reply-To: <1461932322-1206-1-git-send-email-ashoks@broadcom.com>
References: <1461932322-1206-1-git-send-email-ashoks@broadcom.com>
Message-ID: <20160429130230.GU4914@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.04.16 05:18:42, Ashok Kumar wrote:
> In the case of systems having multi socket and multi ITS, allocating
> local node memory for ITS device table, collection table, interrupt
> translation table and command queue will help in reducing inter-chip
> traffic even though they(except command queue) could be cached in the GIC.
> 
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> ---
> This patch is created on top of Cavium thunderx erratum 23144 patch [1].
> 
> I am not sure how to do this for ACPI as GIC ITS ID in MADT doesn't map to
> _PXM. Am I missing something here? Any thoughts?

For ACPI we enable the #23144 workaround differently. In that case we
determine the node using MPIDR_AFFINITY_LEVEL() for this. I am going
to send a patch for this soon (but this is ThunderX specific and only
works for the errata handler).

-Robert

> [1] https://lkml.org/lkml/2016/4/15/830 - [PATCH v5] irqchip, gicv3-its, \
> numa: Enable workaround for Cavium thunderx erratum 23144
