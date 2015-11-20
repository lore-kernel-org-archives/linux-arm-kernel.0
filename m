From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 17:16:04 +0000
Subject: [PATCH v11 3/5] arm: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <20151120164702.GF8644@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1511101411570.5676@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1511201430200.1107@kaball.uk.xensource.com>
 <564F2FD0.6040905@codeaurora.org>
 <alpine.DEB.2.02.1511201439280.1107@kaball.uk.xensource.com>
 <20151120164702.GF8644@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1511201713300.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015, Russell King - ARM Linux wrote:
> On Fri, Nov 20, 2015 at 02:40:31PM +0000, Stefano Stabellini wrote:
> > On Fri, 20 Nov 2015, Christopher Covington wrote:
> > > Hi Stefano,
> > > 
> > > On 11/20/2015 09:31 AM, Stefano Stabellini wrote:
> > > > On Tue, 10 Nov 2015, Stefano Stabellini wrote:
> > > >> On Thu, 5 Nov 2015, Stefano Stabellini wrote:
> > > >>> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM.
> > > >>>
> > > >>> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> > > >>> runtime pvops patching needed.
> > > >>>
> > > >>> This allows us to make use of steal_account_process_tick for stolen
> > > >>> ticks accounting.
> > > >>>
> > > >>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > >>> Acked-by: Christopher Covington <cov@codeaurora.org>
> > > >>> Acked-by: Ian Campbell <ian.campbell@citrix.com>
> > > >>> CC: linux at arm.linux.org.uk
> > > >>> CC: will.deacon at arm.com
> > > >>> CC: nico at linaro.org
> > > >>> CC: marc.zyngier at arm.com
> > > >>> CC: cov at codeaurora.org
> > > >>> CC: arnd at arndb.de
> > > >>> CC: olof at lixom.net
> > > >>
> > > >>
> > > >> Russell,
> > > >> are you OK with this patch?
> > > > 
> > > > Russell,
> > > > 
> > > > I am going to drop this patch and add a small #ifdef to
> > > > arch/arm/xen/enlighten.c to be able to use this functionality on arm64.
> > > > 
> > > > If you change your mind let me know.
> > > 
> > > It appears to me as though he's not copied on this message.
> > 
> > He was. He is now in To:.
> 
> I think the patch is fine.

Thanks


> Sorry, but I no longer read every email that passes by due to the amount
> of email I now receive, and due to the nature of modern email clients with
> their stupid ideas about how to formulate the To: and Cc: headers for
> replies[*], I attach no significance to being mentioned in either the To:
> or Cc: headers.
> 
> Overall, what this means is it's now difficult to attact my attention to
> any particular thread.  Sorry about that, I have no solution to this
> problem.

FWIW as somebody that receives pretty large amounts of emails myself
with my name in CC or To, I understand and I don't have a solution
either :-(


> * - modern mailers have started to preserve the To: and Cc: headers from
> the message being replied to, which means that if I'm mentioned in the
> To: header initially, my address stays in the To: header despite the
> discussion not being directed _at_ me.  Hence, deciding what to reply to
> based on where my address appears in the headers is meaningless with
> modern mail clients.
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
