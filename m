From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 14:21:24 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20110523132124.GI17672@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 12:16:48PM +0100, Catalin Marinas wrote:
> Newer versions of gcc generate unaligned accesses by default, causing
> kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
> -mno-unaligned-access option to gcc.

This description doesn't make sense.  If we have alignment traps enabled,
then we _expect_ to fix up unaligned loads and stores.

Therefore there should be no panic if CONFIG_ALIGNMENT_TRAP is enabled.

So what's the _actual_ problem that this is trying to address?  What's
the panic/oops look like?  And that information should be in the commit
description _anyway_.
