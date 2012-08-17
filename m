From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 02:39:12 -0700
Subject: [PATCH v2 15/31] arm64: SMP support
In-Reply-To: <20120817093250.GB24389@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-16-git-send-email-catalin.marinas@arm.com>
 <20120817092133.GR11011@atomide.com>
 <20120817093250.GB24389@arm.com>
Message-ID: <20120817093912.GW11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120817 02:33]:
> On Fri, Aug 17, 2012 at 10:21:33AM +0100, Tony Lindgren wrote:
> > * Catalin Marinas <catalin.marinas@arm.com> [120814 11:05]:
> > > This patch adds SMP initialisation and spinlocks implementation for
> > > AArch64. The spinlock support uses the new load-acquire/store-release
> > > instructions to avoid explicit barriers. The architecture also specifies
> > > that an event is automatically generated when clearing the exclusive
> > > monitor state to wake up processors in WFE, so there is no need for an
> > > explicit DSB/SEV instruction sequence. The SEVL instruction is used to
> > > set the exclusive monitor locally as there is no conditional WFE and a
> > > branch is more expensive.
> > 
> > Do we always have SMP hardware on arm64? Or are we going to need to
> > again add smp_on_up support later on?
> 
> There isn't anything in the architecture specs that mandates multiple
> cores but given the current trend it's very likely that we'll always
> have MP.
> 
> An improvement in AArch64 is that we can use the SMP cache/TLB ops (the
> inner shareable variants) even on a UP system so there is no need for
> run-time code patching for correct execution.

That's good to hear!

Tony
