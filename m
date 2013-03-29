From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 29 Mar 2013 14:04:55 -0400 (EDT)
Subject: [PATCH v4 2/2] arm: prefer PSCI for SMP bringup
In-Reply-To: <alpine.DEB.2.02.1303291735080.4430@kaball.uk.xensource.com>
References: <1364575371-8926-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1303291320580.1372@syhkavp.arg>
 <alpine.DEB.2.02.1303291735080.4430@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1303291400190.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Mar 2013, Stefano Stabellini wrote:

> On Fri, 29 Mar 2013, Nicolas Pitre wrote:
> > This way the 
> > priority order would be:
> > 
> > - If mdesc->smp_init is non null then use that.
> > 
> > - Otherwise, if PSCI is available then use that.
> > 
> > - Otherwise use mdesc->smp.
> > 
> > This way, if the PSCI default has to be overriden (like in the MCPM case 
> > because it needs to wrap PSCI itself, or to cover Rob's concern) then 
> > this can be achieved at run time on a per mdesc basis.
> 
> Actually that's not a bad idea, it could make everybody happy.
> What about the following, in this precise order:
> 
> - if a xen hypervisor node is present on device tree, use PSCI;
> - otherwise if mdesc->smp_init is non null then use it;
> - otherwise if PSCI is available then use it;
> - otherwise use mdesc->smp.
> 
> It's the most practical solution to satisfy everybody's needs.

Regardless of my previous email suggesting a mdesc for xen, I still 
don't understand why you need this absolute priority for Xen.  Isn't my 
original suggestion sufficient?

The likely reason why mdesc->smp_init might be needed is to provide an 
extra encapsulation layer before actually using PSCI instead of using it 
directly.  Why would you need to bypass that?


Nicolas
