From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 May 2014 18:00:28 +0100
Subject: [PATCH] arm64: Introduce execute-only page access permissions
In-Reply-To: <1399045792-5490-1-git-send-email-catalin.marinas@arm.com>
References: <1399045792-5490-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20140502170027.GE20642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 04:49:52PM +0100, Catalin Marinas wrote:
> The ARMv8 architecture allows execute-only user permissions by clearing
> the PTE_UXN and PTE_USER bits. The kernel, however, can still access
> such page.
> 
> This patch changes the arm64 __P100 and __S100 protection_map[] macros
> to the new __PAGE_EXECONLY attributes. A side effect is that
> pte_valid_user() no longer triggers for __PAGE_EXECONLY since PTE_USER
> isn't set. To work around this, the check is done on the PTE_NG bit via
> the pte_valid_ng() macro. VM_READ is also checked now for page faults.

How does this interact with things like ptrace and pipes? Can I get the
kernel to read my text for me?

Also: do we really want to differ from x86 here?

Will
