From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Feb 2013 19:39:02 -0700
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <1361492355.1574.7@snotra>
References: <20130221231106.GA24426@obsidianresearch.com>
 <1361492355.1574.7@snotra>
Message-ID: <20130222023902.GC11169@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 06:19:15PM -0600, Scott Wood wrote:

> >While embedded focused PPC stuff seems to tend to keep the kernel and
> >DT together.
> 
> At least on the Freescale side of "embedded focused PPC stuff", we
> have not kept the kernel and DT together.  It's actually U-Boot that
> the dts files in the kernel tree are tied to, since they contain

Sorry to be unclear, I only ment that the dt sources themselves are in
the kernel, not say, in the uboot repository or otherwise.

> out where to make the modification.  Usually U-Boot is the only
> relevant loader for a particular board, but not always -- hence
> "adder875-redboot.dts" and "adder875-uboot.dts".  Even when U-Boot

At least on ARM Kirkwood these sorts of differences are minimized by
having Linux know how to reprogram the SOC's address map registers
when it starts up .. Although that is helped by having all the boot
loaders put the address map control registers at the same address ;)

Jason
