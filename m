From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 25 Feb 2013 17:05:39 +0100
Subject: [PATCH] ARM: head: fix swapper and idmap population with LPAE and
 big-endian
In-Reply-To: <1361805401-8629-1-git-send-email-will.deacon@arm.com>
References: <1361805401-8629-1-git-send-email-will.deacon@arm.com>
Message-ID: <fc39410e45e86f30d1f4fec192f35f64@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Feb 2013 15:16:41 +0000, Will Deacon <will.deacon@arm.com>
wrote:
> The LPAE page table format uses 64-bit descriptors, so we need to take
> endianness into account when populating the swapper and idmap tables
> during early initialisation.
> 
> This patch ensures that we store the two words making up each page table
> entry in the correct order when running big-endian.
> 
> Cc: <stable@vger.kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

FWIW, tested as a KVM guest.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

        M.
-- 
Fast, cheap, reliable. Pick two.
