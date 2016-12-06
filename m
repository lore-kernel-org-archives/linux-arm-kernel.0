From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 15:28:38 +0000
Subject: [PATCH 1/1] arm64: Correcting format specifier for printing 64
 bit addresses
In-Reply-To: <20161206152637.GC16701@e104818-lin.cambridge.arm.com>
References: <1480925393-8386-1-git-send-email-maninder1.s@samsung.com>
 <20161205112421.GB14058@arm.com>
 <20161206152637.GC16701@e104818-lin.cambridge.arm.com>
Message-ID: <20161206152837.GM2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 03:26:37PM +0000, Catalin Marinas wrote:
> On Mon, Dec 05, 2016 at 11:24:21AM +0000, Will Deacon wrote:
> > On Mon, Dec 05, 2016 at 01:39:53PM +0530, Maninder Singh wrote:
> > > This patch corrects format specifier for printing 64 bit addresses.
> > > 
> > > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> > > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> > > ---
> > >  arch/arm64/kernel/signal.c |  2 +-
> > >  arch/arm64/kvm/sys_regs.c  |  8 ++++++--
> > >  arch/arm64/mm/fault.c      | 15 ++++++++++-----
> > >  arch/arm64/mm/mmu.c        |  4 ++--
> > >  4 files changed, 19 insertions(+), 10 deletions(-)
> > 
> > Any reason not to fix kvm/trace.h too?
> 
> If the KVM guys are ok, I can fold the hunk below into this patch:
> 
> diff --git a/arch/arm64/kvm/trace.h b/arch/arm64/kvm/trace.h
> index 7fb0008c4fa3..e117123d414b 100644
> --- a/arch/arm64/kvm/trace.h
> +++ b/arch/arm64/kvm/trace.h
> @@ -20,7 +20,7 @@ TRACE_EVENT(kvm_wfx_arm64,
>  		__entry->is_wfe  = is_wfe;
>  	),
>  
> -	TP_printk("guest executed wf%c at: 0x%08lx",
> +	TP_printk("guest executed wf%c at: 0x%016lx",
>  		  __entry->is_wfe ? 'e' : 'i', __entry->vcpu_pc)
>  );
>  
> @@ -40,7 +40,7 @@ TRACE_EVENT(kvm_hvc_arm64,
>  		__entry->imm = imm;
>  	),
>  
> -	TP_printk("HVC at 0x%08lx (r0: 0x%08lx, imm: 0x%lx)",
> +	TP_printk("HVC at 0x%016lx (r0: 0x%016lx, imm: 0x%lx)",

Not sure we need the 016 prefix for r0.

Will
