From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 10:35:30 +0100
Subject: [PATCH v3 1/7] ARM: Align machine_desc.phys_io to a 1MB section
In-Reply-To: <20100621091331.22752.73990.stgit@e102109-lin.cambridge.arm.com>
References: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
	<20100621091331.22752.73990.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621093530.GE7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 10:13:31AM +0100, Catalin Marinas wrote:
> Platforms like RealView don't pass a section-aligned pointer via the
> machine_desc structure. This patch aligns the pointer in the
> __create_page_tables function. Reported by Tony Thompson.

I still say this is the wrong way.  As I've said before, please fix it
at the machine_desc initialization point.  If you want, pass it as the
section frame number itself (address >> 20) rather than the address to
allow for more addressing space.
