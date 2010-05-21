From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 21:43:43 +0100
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <874oi157c6.fsf@free.fr>
References: <874oi157c6.fsf@free.fr>
Message-ID: <20100521204343.GA18032@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 10:27:05PM +0200, Robert Jarzmik wrote:
> I pulled the 2.6.33 kernel and tried my mainboard with it (mioa701). My
> kernel boots fine, but initrd load always fails.

Please post all the kernel messages.

> After digging a bit in arch/arm/mm/init.c, I find that :
>  - phys_initrd_start = 0xa0508000
>  - phys_initrd_size = 3 759 480
>  - initrd_start = 0 and initrd_end = 0

It's unclear where you're checking this.  The virtual pointers are only
setup if we're satisfied that the phys_* are within RAM, and we can
exclusively reserve the region.

If we can't reserve the region, that means something's overwritten it
during kernel boot and it's become unusable.
