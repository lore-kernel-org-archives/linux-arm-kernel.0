From: j.neuschaefer@gmx.net (Jonathan =?utf-8?Q?Neusch=C3=A4fer?=)
Date: Wed, 15 Dec 2010 00:00:01 +0100
Subject: [PATCH] arch/arm/kernel: use cpu_relax() in halt loops
In-Reply-To: <20101214225126.GD24303@n2100.arm.linux.org.uk>
References: <20101214224848.GA1706@debian.debian>
	<20101214225126.GD24303@n2100.arm.linux.org.uk>
Message-ID: <20101214230001.GA1747@debian.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 10:51:26PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 14, 2010 at 11:48:48PM +0100, Jonathan Neusch?fer wrote:
> > Looking throught arch/arm/kernel/ I found some halt loops.
> > I just thought we could save some power here using cpu_relax(),
> > or am I missing something?
> 
> #if __LINUX_ARM_ARCH__ == 6
> #define cpu_relax()                     smp_mb()
> #else
> #define cpu_relax()                     barrier()
> #endif
> 
> IOW, it's either a memory barrier or compiler barrier on ARM; it
> doesn't do any power saving.

Okay, thanks for that explanation.
