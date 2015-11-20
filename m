From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 14:40:31 +0000
Subject: [PATCH v11 3/5] arm: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <564F2FD0.6040905@codeaurora.org>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1511101411570.5676@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1511201430200.1107@kaball.uk.xensource.com>
 <564F2FD0.6040905@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1511201439280.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015, Christopher Covington wrote:
> Hi Stefano,
> 
> On 11/20/2015 09:31 AM, Stefano Stabellini wrote:
> > On Tue, 10 Nov 2015, Stefano Stabellini wrote:
> >> On Thu, 5 Nov 2015, Stefano Stabellini wrote:
> >>> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM.
> >>>
> >>> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> >>> runtime pvops patching needed.
> >>>
> >>> This allows us to make use of steal_account_process_tick for stolen
> >>> ticks accounting.
> >>>
> >>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >>> Acked-by: Christopher Covington <cov@codeaurora.org>
> >>> Acked-by: Ian Campbell <ian.campbell@citrix.com>
> >>> CC: linux at arm.linux.org.uk
> >>> CC: will.deacon at arm.com
> >>> CC: nico at linaro.org
> >>> CC: marc.zyngier at arm.com
> >>> CC: cov at codeaurora.org
> >>> CC: arnd at arndb.de
> >>> CC: olof at lixom.net
> >>
> >>
> >> Russell,
> >> are you OK with this patch?
> > 
> > Russell,
> > 
> > I am going to drop this patch and add a small #ifdef to
> > arch/arm/xen/enlighten.c to be able to use this functionality on arm64.
> > 
> > If you change your mind let me know.
> 
> It appears to me as though he's not copied on this message.

He was. He is now in To:.
