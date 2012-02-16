From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 09:05:42 +0000
Subject: [PATCH v2 00/13] Make mach/irqs.h optional
In-Reply-To: <20120216084536.GH13673@n2100.arm.linux.org.uk>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <20120216084536.GH13673@n2100.arm.linux.org.uk>
Message-ID: <20120216090542.GA23641@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 08:45:36AM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 20, 2012 at 02:32:58PM -0600, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > This series removes the include of mach/irqs.h from asm/irq.h when
> > SPARSE_IRQ is selected. Platforms which select SPARSE_IRQ have been
> > updated.
> 
> Rob,
> 
> Last night, I merged devel-stable into the stuff which gets built, and it
> seems your IRQ changes are breaking PXA:
> 
> Before merge:
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=129
> 
> After merge:
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=137

Also see SA11x0 breakage - before:
http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=127
after:
http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=135
