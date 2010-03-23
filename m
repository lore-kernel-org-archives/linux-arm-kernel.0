From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:39:40 +0000
Subject: [PATCH 4/5] ARM: Align machine_desc.phys_io to a 1MB section
In-Reply-To: <20100322151956.6353.88717.stgit@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
	<20100322151956.6353.88717.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323213940.GK19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 03:19:56PM +0000, Catalin Marinas wrote:
> Platforms like RealView don't pass a section-aligned pointer via the
> machine_desc structure. This patch aligns the pointer in the
> __create_page_tables function. Reported by Tony Thompson.

I'd much rather the pointer in the structure was properly aligned,
rather than adding code to make it so.
