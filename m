From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 May 2010 16:02:09 +0100
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100325233248.GM24984@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Message-ID: <20100505150209.GC2606@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 11:32:48PM +0000, Russell King - ARM Linux wrote:
> LMB... logical memory blocks.
> 
> LM is a different method of managing memory regions during the early
> boot period when the usual kernel memory allocators are not up and
> running.  LMB has been in the kernel for quite some time, and is
> already being used by Microblaze, PPC, SH and Sparc.  Maybe soon x86
> as well.
> 
> The motivation for this is that there appears to be plans to kill off
> the other method - bootmem.  (see discussions on the linux-arch ml.)

I've now queued the first three patches in this series for the next
merge window, which is basically the preparation for moving to LMB.
Essentially, that's:

- removing useless includes of linux/bootmem.h
- sorting the meminfo array prior to sanity_check_meminfo()
- moving the mapping of lowmem into mmu.c and making create_mapping()
  static

None of these changes should affect any currently merged platforms, and
wouldn't be affected by Ben's LMB updates either.
