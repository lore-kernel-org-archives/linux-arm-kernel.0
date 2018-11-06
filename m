From: mbenes@suse.cz (Miroslav Benes)
Date: Tue, 6 Nov 2018 17:49:07 +0100 (CET)
Subject: [PATCH v4 2/3] arm64: implement live patching
In-Reply-To: <20181026142152.5F0D868C95@newverein.lst.de>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142152.5F0D868C95@newverein.lst.de>
Message-ID: <alpine.LSU.2.21.1811061745440.30614@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 26 Oct 2018, Torsten Duwe wrote:

> Based on ftrace with regs, do the usual thing.
> (see Documentation/livepatch/livepatch.txt)
> 
> Use task flag bit 6 to track patch transisiton state for the consistency
> model. Add it to the work mask so it gets cleared on all kernel exits to
> userland.
> 
> Tell livepatch regs->pc is the place to change the return address.
> Make sure the graph tracer call hook is only called on the final function
> entry in case regs->pc gets modified after an interception.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

It looks good now apart from arm64 asm part which should be reviewed by 
someone else.

However, could you summarize our analysis regarding post-module-load calls 
of apply_relocate_add() in the commit log, please? It is important for 
future reference.

Thanks,
Miroslav
