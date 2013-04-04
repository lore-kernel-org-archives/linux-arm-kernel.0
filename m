From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 4 Apr 2013 06:16:40 -0300
Subject: [RFCv1 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130404091639.GA2245@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, Mar 26, 2013 at 05:52:15PM +0100, Thomas Petazzoni wrote:
> 
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform and the Armada 370 DB platform with an Intel
> e1000e PCIe network card that supports MSI.
> 
> This is based on work done by Lior Amsalem <alior@marvell.com>.
> 
> The patches do the following:
> 
>  * Patches 1, 2 and 3 move the IRQ controller driver of Armada 370/XP
>    platforms from arch/arm/mach-mvebu/ into drivers/irqchip/ and use
>    the proper irqchip infrastructure. Those changes are not strictly
>    needed to add MSI interrupts support, but since we will be touching
>    the IRQ controller driver anyway, it sounded like the right time to
>    do this move.
> 

Given the IRQ controller move to drivers/irqchip is independent of MSI
work, and that we've already agreed this move is fine (Arnd has acked
patch 2), may I suggest that you resend these three first patches
(and perhaps the fourth?) as a separate patchset to be included in v3.10.

This has the advantage that further development on IRQ controller can be
done directly on its proper place, and also the MSI patchset can be
simplified.

What do you think?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
