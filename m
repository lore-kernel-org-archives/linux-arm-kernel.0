From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 May 2012 12:16:36 +0100
Subject: [RFC] Remove support for ARMv3 ARM610 and ARM710 CPUs
In-Reply-To: <20120504095645.GD26481@n2100.arm.linux.org.uk>
References: <20120504095645.GD26481@n2100.arm.linux.org.uk>
Message-ID: <20120504111635.GE27893@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 10:56:45AM +0100, Russell King - ARM Linux wrote:
> This patch removes support for ARMv3 CPUs, which haven't worked properly
> for quite some time (see the FIXME comment in arch/arm/mm/fault.c).  The
> only V3 parts left is the cache model for ARMv3, which is needed for some
> odd reason by ARM740T CPUs, and being able to build with -march=armv3,
> which is required for the RiscPC platform due to its bus structure.
> 
> What this patch shows is how well abstracted the ARMv3 support is.
> Apart from removing the multi-support selection conditionals in the
> glue-*.h and similar files, and the ARM710 hack in entry-common.S,
> ARMv3 support does not affect any other core code files.  That flies
> directly in the face of people who whinge and moan about ARMv3 support
> being painful in the kernel; if it's soo well abstracted then it isn't
> being a problem.
> 
> So, after this commit, the only ARMv3 specific code left is
> arch/arm/mm/cache-v3.S and its selection in asm/glue-cache.h.
> 
> Irrespective of the whingers, I think this is something we should do,
> because it has been broken at runtime for quite some time and no one
> has shown any interest in it.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

The earliest CPU I have is a 720t, so I can't see the reason for reviving
this broken code.

FWIW:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
