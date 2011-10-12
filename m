From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Oct 2011 18:20:07 +0100
Subject: [PATCH 1/5 v4] ARM Realview PCIX map include file changes
In-Reply-To: <000001cc872e$d1aaf870$7500e950$@tuckley@arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
	<20111007142723.19554.88566.stgit@e102602-lin.cambridge.arm.com>
	<20111007192224.GB25689@n2100.arm.linux.org.uk>
	<000001cc872e$d1aaf870$7500e950$@tuckley@arm.com>
Message-ID: <20111012172007.GA21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 10:27:08AM +0100, Colin Tuckley wrote:
> Ah, I wasn't aware of that. However when I include asm/io.h and remove the

The general rule is that linux/io.h includes asm/io.h, which in turn
includes mach/io.h includes and nothing should include either asm/io.h
nor mach/io.h directly - if it does, things probably break - which is
desirable behaviour because that indicates that the include is wrong.

> A quick check shows that the piece of code you quote above does not exist in
> my (3.1.0-rc9) source tree.

It's not in -rc9, but will be during the next merge window - and is in
linux-next.
