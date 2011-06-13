From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 13:26:01 +0100
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
Message-ID: <20110613122601.GC12325@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 01:04:02PM +0100, Frank Hofmann wrote:
>   To make it clear: IF AND ONLY IF your suspend(-to-ram) func looks like:
>
> 	ENTRY(acmeSoC_cpu_suspend)
> 		stmfd	sp!, {r4-r12,lr}
> 		ldr	r3, resume_mmu_done
> 		bl	cpu_suspend
> 	resume_mmu_done:
> 		ldmfd	sp!, {r3-r12,pc}
> 	ENDPROC(acmeSoC_cpu_suspend)

Nothing has that - because you can't execute that ldmfd after the call
to cpu_suspend returns.  I don't think you've understood what I said on
that subject in the previous thread.
