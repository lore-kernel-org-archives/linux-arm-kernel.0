From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 27 Sep 2011 11:15:23 +0100
Subject: Porting linux to Stellaris Cortex-M3
In-Reply-To: <20110927092906.GA9692@n2100.arm.linux.org.uk>
References: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
	<20110927092906.GA9692@n2100.arm.linux.org.uk>
Message-ID: <20110927101523.GF14237@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 10:29:06AM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 26, 2011 at 05:19:39PM -0300, Fernando Endo wrote:
> > - BUG: scheduling while atomic: init/1/0xffff000a
> 
> The last figure is the preempt count.  This is made up from:
> 
>  * - bits 0-7 are the preemption count (max preemption depth: 256)
>  * - bits 8-15 are the softirq count (max # of softirqs: 256)
>  * - bits 16-25 are the hardirq count (max # of nested hardirqs: 1024)
>  * - bit 26 is the NMI_MASK
>  * - bit 28 is the PREEMPT_ACTIVE flag
> 
> That seems to be saying that preemption has been disabled 10 times.
> The upper 16-bits being all-ones seems to be rather insane - maybe
> there's an additional __irq_exit() or irq_exit() call somewhere in
> one of your code paths.

Fernando, do you have CONFIG_PREEMPT enabled in your kernel? That's not
currently possible with my Cortex-M3 port (see the "Exception handling"
section in the M3 wiki page for an explanation).

-- 
Catalin
