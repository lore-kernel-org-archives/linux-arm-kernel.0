From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Mar 2017 19:29:28 +0000
Subject: Creating kernel mappings for memory initially marked with
 bootmem NOMAP?
In-Reply-To: <20170308192653.GB21222@n2100.armlinux.org.uk>
References: <c17b0a16-fde5-9254-f84a-418972201eae@gmail.com>
 <20170308192653.GB21222@n2100.armlinux.org.uk>
Message-ID: <20170308192928.GC21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 07:26:53PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 08, 2017 at 11:03:43AM -0800, Florian Fainelli wrote:
> > Now, we have some peripherals that want large chunks of physically and
> > virtually contiguous memory that belong to these memblock NOMAP ranges.
> > I have no problems using mmap() against this memory, because the kernel
> > will do what is necessary for a process to map it for me. The struggle
> > is for a kernel driver which specifies a range of physical memory and
> > size, and expects a virtually contiguous mapping in return (not using
> > DMA-API, because reasons).
> 
> Will vm_iomap_memory() do the job?

Sorry, I thought you were asking about userspace.  The memremap()
family of functions is what you want for mapping it into the kernel.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
