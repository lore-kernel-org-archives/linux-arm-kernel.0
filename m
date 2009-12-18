From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 20:03:07 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <20091218195432.GC1205@shareable.org>
References: <20091218180406.32211.72790.stgit@e101986-lin>
	<20091218182007.GF5527@n2100.arm.linux.org.uk>
	<20091218195432.GC1205@shareable.org>
Message-ID: <20091218200307.GJ5527@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 07:54:32PM +0000, Jamie Lokier wrote:
> There might be thread synchronisation code using SWP/SWPB on shared
> memory which gets mapped uncached to prevent aliasing.

The shared mmap fixup doesn't get triggered on ARMv7 (or any VIPT
ARM cached system).  Such fixup is only applicable to VIVT ARMs.
