From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 13:06:54 +0000
Subject: [PATCH] ARM: include needed linux/cpu.h in asm/cpu.h
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C041C104@dbde02.ent.ti.com>
References: <1262518489-6867-1-git-send-email-santosh.shilimkar@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C041C104@dbde02.ent.ti.com>
Message-ID: <20100110130654.GA7716@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2010 at 01:14:57PM +0530, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Sunday, January 03, 2010 5:05 PM
> > To: linux at arm.linux.org.uk
> > Cc: linux-arm-kernel at lists.infradead.org; tony at atomide.com; Shilimkar, Santosh
> > Subject: [PATCH] ARM: include needed linux/cpu.h in asm/cpu.h
> > 
> > The file arch/arm/include/asm/cpu.h needs to include 'linux/cpu.h' to
> > meet its dependency. Otherwise when using "struct cpuinfo_arm" and including
> > just 'asm/cpu.h' throws below error -
> > 	arch/arm/include/asm/cpu.h:16: error: field 'cpu' has incomplete type
> > 
> > To fix this  otherway, one can also include both linux/cpu.h and asm/cpu.h
> > ubut it shoudn't be that way. So this patch fixes this by including the
> > linux/cpu.h in asm/cpu.h,so that including alone asm/cpu.h is enough.

The version in the patch system had most of the above sentence on one
line.  This is not acceptable; it has to be sensibly manually wrapped
otherwise Linus complains.

Please ensure that future submissions are wrapped preferably before
column 72, thanks.
