From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Dec 2010 22:51:26 +0000
Subject: [PATCH] arch/arm/kernel: use cpu_relax() in halt loops
In-Reply-To: <20101214224848.GA1706@debian.debian>
References: <20101214224848.GA1706@debian.debian>
Message-ID: <20101214225126.GD24303@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 11:48:48PM +0100, Jonathan Neusch?fer wrote:
> Looking throught arch/arm/kernel/ I found some halt loops.
> I just thought we could save some power here using cpu_relax(),
> or am I missing something?

#if __LINUX_ARM_ARCH__ == 6
#define cpu_relax()                     smp_mb()
#else
#define cpu_relax()                     barrier()
#endif

IOW, it's either a memory barrier or compiler barrier on ARM; it
doesn't do any power saving.
