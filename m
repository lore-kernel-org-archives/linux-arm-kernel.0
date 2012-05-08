From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 May 2012 12:17:40 -0400 (EDT)
Subject: [PATCH 2/2] remove the debugging restrictions in devicemaps_init()
In-Reply-To: <20120508071411.GP26481@n2100.arm.linux.org.uk>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
 <1331876668-32492-3-git-send-email-nico@fluxnic.net>
 <20120506163016.GA7412@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1205072340540.21030@xanadu.home>
 <20120508071411.GP26481@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1205081214220.21030@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 May 2012, Russell King - ARM Linux wrote:

> On Tue, May 08, 2012 at 12:19:30AM -0400, Nicolas Pitre wrote:
> > However, the switching itself doesn't involve a full cache flush.
> 
> That's where you're wrong.  Look at the switch_mm() helpers in proc-*.S.
> StrongARM for example calls v4wb_flush_kern_cache_all() here, which needs
> the cache flushing mappings to be in place in the _current_ page table.

Right.  I had to be wrong somewhere.

What about abstracting the cache area mapping code in a function of its 
own, and calling it inside install_temp_mm() as well?


Nicolas
