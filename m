From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jun 2012 09:28:52 +0100
Subject: v3.4 boot failure on qemu-system-arm -M versatilepb
In-Reply-To: <4FD5A918.7040200@codethink.co.uk>
References: <XNM1$5$0$1$$3$9$0$A$8005401U4fc38a01@hitachi.com>
 <4FC52B61.2000604@gmail.com>
 <XNM1$5$0$1$$3$9$0$A$8005413U4fc5e967@hitachi.com>
 <XNM1$5$0$1$$3$9$0$A$8005415U4fc63e90@hitachi.com>
 <4FD5A918.7040200@codethink.co.uk>
Message-ID: <20120611082852.GB11168@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 09:15:20AM +0100, Ben Dooks wrote:
> We've seen the same problem. Limiting the __io() to the IO_SPACE_LIMIT
> will not fix the problem as the previous code was using a 1:1 CPU to
> PCI space view (which is why it was allocating space at 0x44000000).
>
> Either the __io() macro needs to add the base of PCI space, or the
> limit needs to be restored.

Or the bus setup needs to be fixed to be more conventional, which is
something I always did for the PCI platforms I had hardware for.
