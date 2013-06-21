From: w@1wt.eu (Willy Tarreau)
Date: Fri, 21 Jun 2013 19:39:37 +0200
Subject: [PATCH v7] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1371828664-3681-2-git-send-email-gregory.clement@free-electrons.com>
References: <1371828664-3681-1-git-send-email-gregory.clement@free-electrons.com>
 <1371828664-3681-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130621173937.GG7406@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Works fine here, kudos Greg! Feel free to add my Tested-by if you
want :

    Tested-By: Willy Tarreau <w@1wt.eu>

Best regards,
Willy
