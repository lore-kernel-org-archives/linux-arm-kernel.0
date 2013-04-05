From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Apr 2013 12:22:05 -0400 (EDT)
Subject: [PATCH v6 4/4] xen/arm: introduce xen_early_init, use PSCI on xen
In-Reply-To: <1365167495-18508-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.LFD.2.03.1304051217560.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Stefano Stabellini wrote:

> Split xen_guest_init in two functions, one of them (xen_early_init) is
> going to be called very early from setup_arch.
> 
> Change machine_desc->smp_init to xen_smp_init if Xen is present on the
> platform. xen_smp_init just sets smp_ops to psci_smp_ops.

I still think the above is redundant, especially since psci_smp_ops has 
priority over default mdesc->smp_ops.  And doing so does break MCPM. But 
we're apparently going in circle over this issue.


Nicolas
