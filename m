From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2009 20:44:03 +0100
Subject: [PATCH] arm: Make kprobes unregistration SMP safe
In-Reply-To: <alpine.LFD.2.00.0909172039070.24133@xanadu.home>
References: <1253078476.5021.65.camel@funkybook>
	<alpine.LFD.2.00.0909172039070.24133@xanadu.home>
Message-ID: <20090918194403.GC6601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2009 at 08:40:10PM -0400, Nicolas Pitre wrote:
> On Wed, 16 Sep 2009, Fr?d?ric RISS wrote:
> 
> > ARM kprobes use an illegal instruction to trigger kprobes. In the
> > current implementation, there's a race between the unregistration of a
> > kprobe and the illegal instruction exception handler if they run at the
> > same time on different cores. 
> > 
> > When reading the value of the undefined instruction, the exception
> > handler might get the original legal instruction as just patched
> > concurrently by arch_disarm_kprobe(). When this happen the kprobe
> > handler won't run, and thus the exception handler will oops because it
> > believe it just hit an undefined instruction in kernel space.
> > 
> > The following patch synchronizes the code patching in the kprobes
> > unregistration using stop_machine and thus avoids the above race.
> > 
> > Signed-off-by: Frederic RISS <frederic.riss@gmail.com>
> 
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

Fr?d?ric, please submit to the patch system, thanks.
