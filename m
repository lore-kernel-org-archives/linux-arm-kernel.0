From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2012 19:46:34 +0000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
References: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120220194634.GK26840@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 06:37:09PM +0000, Will Deacon wrote:
> Commit 68b7f715 ("nommu: ptrace support") added definitions for
> PT_TEXT_ADDR and friends, as well as adding ptrace support for reading
> from these magic offsets.
> 
> Unfortunately, this has probably never worked, since ptrace_read_user
> predicates reading on off < sizeof(struct user), returning -EOI
> otherwise.
> 
> This patch moves the offset size check until after we have tried to
> match it against either a magic value or an offset into pt_regs.

Does this actually get used?  The fact that it's been broken from day one
and no one's raised the issue in 2.5 years suggests that it's dead code.
