From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 23 May 2011 13:30:43 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <yw1x8vtxr43w.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> Newer versions of gcc generate unaligned accesses by default, causing
> kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
> -mno-unaligned-access option to gcc.

Wouldn't it make more sense to disable strict alignment checking in
kernel mode regardless of this option.  I can't imagine why it would
ever be desirable.  IMO the usermode default should also be changed to
allow unaligned accesses on ARMv6 and up.

I don't mind this patch as such, but I would not consider it a correct
solution.

-- 
M?ns Rullg?rd
mans at mansr.com
