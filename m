From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jun 2011 10:41:25 +0100
Subject: [PATCH 00/10] Enhance /dev/mem to allow read/write of
	arbitrary physical addresses
In-Reply-To: <20110617093032.GA19235@elte.hu>
References: <201106171038.25988.ptesarik@suse.cz>
	<20110617093032.GA19235@elte.hu>
Message-ID: <20110617094125.GE32629@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2011 at 11:30:32AM +0200, Ingo Molnar wrote:
> I'm aware of these current /dev/mem uses:
> 
>  - Xorg maps below 4G non-RAM addresses and the video BIOS
> 
>  - It used to have some debugging role but these days kexec and kgdb 
>    has largely taken over that role - partly due to the 4G limit.
> 
>  - there's some really horrible out-of-tree drivers that do mmap()s
>    via /dev/mem, those should be fixed if they want to move beyond 
>    4G: their char device should be mmap()able.
> 
>  - all distro kernel's i'm aware of use CONFIG_STRICT_DEVMEM=y, which
>    restricts /dev/mem to non-RAM pages of physical memory.
>    [ With the sad inclusion of the first 1MB, which Xorg needs. ]

There's another use case for /dev/mem:

 - debugging via devmem2 on embedded platforms, where you want to be able
   to boot a kernel, and then peek and poke at MMIO registers either to
   verify register values or test things out.
