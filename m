From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 28 Jan 2014 07:31:24 -0300
Subject: [PATCH v5 01/20] ARM: Introduce atomic MMIO modify
In-Reply-To: <1390836440-12744-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140128103122.GB13052@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 12:27:01PM -0300, Ezequiel Garcia wrote:
> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> respectively. The rationale for this is that some users may not require
> register write completion but only thread-safe access to a register.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Russell,
> 
> Can you confirm this patch is on its way to v3.14?
> 

ping?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
