From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Aug 2011 21:25:36 -0400 (EDT)
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1108232120590.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2011, Will Deacon wrote:

> Hello,
> 
> This is version 4 of the patches originally posted here:
> 
> v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
> v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html
> v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053252.html
> 
> There are many changes since v3. Notably:
> 	- Support for Thumb-2
> 	- Based on 3.1-rc3 (now that some of the previous patches have
> 	  been merged)
> 	- The reserved stack page now sits below swapper and is reserved
> 	  by memblock during memory init. This has the advantage of being
> 	  at a known physical address for a platform, which will be helpful
> 	  for non-hotplug SMP booting.

Is this really necessary?  Relying on "known physical address" is often 
going to lead us in situations where that physical address get encoded 
outside the kernel proper and then we're stuck with it forever.  This 
would be more "reliable" if the interface would be passed that address 
and if the page was dynamically allocated/freed.


Nicolas
