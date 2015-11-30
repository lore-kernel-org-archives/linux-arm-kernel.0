From: panand@redhat.com (Pratyush Anand)
Date: Mon, 30 Nov 2015 10:58:43 +0530
Subject: [PATCH v12 05/16] arm64: Add back cpu_reset routines
In-Reply-To: <56586679.8060403@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>
 <56586679.8060403@arm.com>
Message-ID: <20151130052843.GG23908@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2015:02:19:37 PM, Marc Zyngier wrote:
> On 24/11/15 22:25, Geoff Levand wrote:
> > +ENTRY(cpu_soft_restart)
> > +	mov	x18, x0				// cpu_reset
> > +	mov	x0, x1				// el2_switch
> > +	mov	x1, x2				// entry
> > +	mov	x2, x3				// arg0
> > +	mov	x3, x4				// arg1
> > +	ret	x18
> > +ENDPROC(cpu_soft_restart)
> 
> Grepping through the tree, I can only find a single use of
> cpu_soft_restart, with cpu_reset as its first parameter.
> 
> Why do we need this indirection? Having

It is needed because we need to execute cpu_reset() in physical address space.

> 
> void cpu_soft_restart(el2_switch, entry, arg0, arg1);
> 
> should be enough...

We can do with only cpu_soft_restart(), but then a function pointer to __pa() of
it need to be called. May  be current approach is more cleaner.

~Pratyush
