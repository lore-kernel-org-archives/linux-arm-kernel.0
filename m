From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 May 2012 08:14:11 +0100
Subject: [PATCH 2/2] remove the debugging restrictions in devicemaps_init()
In-Reply-To: <alpine.LFD.2.02.1205072340540.21030@xanadu.home>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
 <1331876668-32492-3-git-send-email-nico@fluxnic.net>
 <20120506163016.GA7412@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1205072340540.21030@xanadu.home>
Message-ID: <20120508071411.GP26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 12:19:30AM -0400, Nicolas Pitre wrote:
> However, the switching itself doesn't involve a full cache flush.

That's where you're wrong.  Look at the switch_mm() helpers in proc-*.S.
StrongARM for example calls v4wb_flush_kern_cache_all() here, which needs
the cache flushing mappings to be in place in the _current_ page table.
