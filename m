From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 16 Oct 2015 16:45:55 +0100
Subject: [Xen-devel] xen,arm: enable cpu_hotplug
In-Reply-To: <alpine.DEB.2.02.1510161635520.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
 <561EE3E5.2000105@citrix.com> <1444898398.1607.18.camel@citrix.com>
 <alpine.DEB.2.02.1510161635520.27957@kaball.uk.xensource.com>
Message-ID: <56211BB3.9020605@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/15 16:41, Stefano Stabellini wrote:
> It is possible to shut down cpu1 (psci->cpu_off, which pauses the vcpu)
> but it is not possible to remove cpu1 without removing cpu2 first.
> 
> If the user configures the target to be cpu 2-4, then shuts down cpu2, it
> won't receive any interrupts any more. This is not a cpu-hotplug bug.
> Maybe is a do_psci_cpu_off bug, which should be improved to handle this
> case.

It's neither a PSCI cpu off bug. It's a bug in our vGIC implementation.

Regards,

-- 
Julien Grall
