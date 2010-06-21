From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 10:23:07 +0100
Subject: [PATCH v3 2/7] ARM: Avoid the CONSISTENT_DMA_SIZE warning on
	noMMU builds
In-Reply-To: <20100621091336.22752.78477.stgit@e102109-lin.cambridge.arm.com>
References: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
	<20100621091336.22752.78477.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621092307.GC7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 10:13:36AM +0100, Catalin Marinas wrote:
> This macro is not defined when !CONFIG_MMU.

Just move the definitions into the !CONFIG_MMU section.  No need for
any more ifdefs.
