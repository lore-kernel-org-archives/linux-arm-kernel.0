From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 12:45:46 +0100
Subject: [PATCH 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <20100520143004.22202.71701.stgit@e102109-lin.cambridge.arm.com>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<20100520143004.22202.71701.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100524114546.GB21117@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 03:30:04PM +0100, Catalin Marinas wrote:
> The user pages access rights are also modified for kernel read-only
> access rather than read/write so that the copy-on-write mechanism still
> works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> since writing the TLS value to the high vectors page isn't possible.

When FIQ handlers are installed/removed, the vector page is also written,
so the above restriction is incompatible with FIQ support.

Do we want to tell people that they can't use FIQs without domain support?
