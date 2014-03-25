From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 25 Mar 2014 12:12:01 +0000
Subject: [PATCH v9 4/5] arm64: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <53316D0F.7040600@arm.com>
References: <alpine.DEB.2.02.1401091755390.21510@kaball.uk.xensource.com>
 <1389292336-9292-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1402171225000.27926@kaball.uk.xensource.com>
 <20140217175552.GB8361@arm.com>
 <alpine.DEB.2.02.1403251119050.8273@kaball.uk.xensource.com>
 <53316D0F.7040600@arm.com>
Message-ID: <alpine.DEB.2.02.1403251211540.20389@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Mar 2014, Marc Zyngier wrote:
> On 25/03/14 11:19, Stefano Stabellini wrote:
> > On Mon, 17 Feb 2014, Catalin Marinas wrote:
> >> On Mon, Feb 17, 2014 at 12:25:42PM +0000, Stefano Stabellini wrote:
> >>> On Thu, 9 Jan 2014, Stefano Stabellini wrote:
> >>>> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM64.
> >>>> Necessary duplication of paravirt.h and paravirt.c with ARM.
> >>>>
> >>>> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> >>>> runtime pvops patching needed.
> >>>>
> >>>> This allows us to make use of steal_account_process_tick for stolen
> >>>> ticks accounting.
> >>>>
> >>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >>>> CC: will.deacon at arm.com
> >>>> CC: nico at linaro.org
> >>>> CC: marc.zyngier at arm.com
> >>>> CC: cov at codeaurora.org
> >>>> CC: arnd at arndb.de
> >>>> CC: olof at lixom.net
> >>>> CC: Catalin.Marinas at arm.com
> >>>
> >>> Catalin, Will, are you happy with this patch for 3.15?
> >>
> >> It's pretty small and looks fine to me. However, I would like someone
> >> with more virtualisation experience than me to ack it (e.g. Marc Z).
> > 
> > Ping? Marc, could you please give it a review?
> 
> Yup, that looks OK to me. It's a generic feature anyway, so I don't see
> any harm in enabling it for Xen. We may also use it for KVM at some point.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks!
