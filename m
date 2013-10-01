From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 1 Oct 2013 19:12:11 +0100
Subject: [PATCH v3 2/3] ARM: mcpm: Implement cpu_kill() to synchronise on
 powerdown
In-Reply-To: <alpine.LFD.2.03.1310011334550.21228@syhkavp.arg>
References: <1380647718-9178-1-git-send-email-Dave.Martin@arm.com>
 <1380647718-9178-3-git-send-email-Dave.Martin@arm.com>
 <alpine.LFD.2.03.1310011334550.21228@syhkavp.arg>
Message-ID: <20131001181211.GC2640@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 01:35:17PM -0400, Nicolas Pitre wrote:
> On Tue, 1 Oct 2013, Dave Martin wrote:
> 
> > CPU hotplug and kexec rely on smp_ops.cpu_kill(), which is supposed
> > to wait for the CPU to park or power down, and perform the last
> > rites (such as disabling clocks etc., where the platform doesn't do
> > this automatically).
> > 
> > kexec in particular is unsafe without performing this
> > synchronisation to park secondaries.  Without it, the secondaries
> > might not be parked when kexec trashes the kernel.
> > 
> > There is no generic way to do this synchronisation, so a new mcpm
> > platform_ops method power_down_finish() is added by this patch.
> > 
> > The new method is mandatory.  A platform which provides no way to
> > detect when CPUs are parked is likely broken.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Thanks!

I can recommend kexec -- speeds up my reboots no end.


I can send the MCPM patches to the patch system, but the TC2 patch
probably ought to go via arm-soc when Russell has a stable branch
available.

Lorenzo's patch fixes something relevant but independent, so should be
mergeable separately.

Any concerns?

Cheers
---Dave
