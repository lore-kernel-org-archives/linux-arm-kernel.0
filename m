From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 22 Jun 2013 12:44:22 -0300
Subject: [PATCH v7] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1371828664-3681-2-git-send-email-gregory.clement@free-electrons.com>
References: <1371828664-3681-1-git-send-email-gregory.clement@free-electrons.com>
 <1371828664-3681-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130622154421.GA475@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Fri, Jun 21, 2013 at 05:31:04PM +0200, Gregory CLEMENT wrote:
> This commit fixes the regression on Armada 370 (the kernal hang during
> boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
> 
> When coming out of either a Wait for Interrupt (WFI) or a Wait for
> Event (WFE) IDLE states, a specific timing sensitivity exists between
> the retiring WFI/WFE instructions and the newly issued subsequent
> instructions. This sensitivity can result in a CPU hang scenario.  The
> workaround is to insert either a Data Synchronization Barrier (DSB) or
> Data Memory Barrier (DMB) command immediately after the WFI/WFE
> instruction.
> 
> This commit was based on the work of Lior Amsalem, but heavily
> modified to apply the errata fix dynamically according to the
> processor type thanks to the suggestions of Russell King and Nicolas
> Pitre.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Cc: <stable@vger.kernel.org>

This patch doesn't seem to apply on any 3.10-rcX;
maybe I'm doing something wrong, but could you double-check this?

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
