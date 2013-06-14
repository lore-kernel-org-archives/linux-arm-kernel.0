From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Jun 2013 18:29:10 +0100
Subject: [PATCHv2] arm: fix pmd flushing in map_init_section
In-Reply-To: <1371229044-3970-1-git-send-email-mark.rutland@arm.com>
References: <20130614165417.GP3245@lvm>
 <1371229044-3970-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20130614172910.GT29271@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:57:24PM +0100, Mark Rutland wrote:
> In e651eab0af: "ARM: 7677/1: LPAE: Fix mapping in alloc_init_section for
> unaligned addresses", the pmd flushing was broken when split out to
> map_init_section. At the end of the final iteration of the while loop,
> pmd will point at the pmd_t immediately after the pmds we updated, and
> thus flush_pmd_entry(pmd) won't flush the newly modified pmds. This has
> been observed to prevent an 11MPCore system from booting.
> 
> This patch fixes this by remembering the address of the first pmd we
> update and using this as the argument to flush_pmd_entry.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: R Sricharan <r.sricharan@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <cdall@cs.columbia.edu>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: stable at vger.kernel.org

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
