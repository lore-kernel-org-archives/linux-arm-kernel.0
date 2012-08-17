From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 02:21:33 -0700
Subject: [PATCH v2 15/31] arm64: SMP support
In-Reply-To: <1344966752-16102-16-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-16-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120817092133.GR11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120814 11:05]:
> This patch adds SMP initialisation and spinlocks implementation for
> AArch64. The spinlock support uses the new load-acquire/store-release
> instructions to avoid explicit barriers. The architecture also specifies
> that an event is automatically generated when clearing the exclusive
> monitor state to wake up processors in WFE, so there is no need for an
> explicit DSB/SEV instruction sequence. The SEVL instruction is used to
> set the exclusive monitor locally as there is no conditional WFE and a
> branch is more expensive.

Do we always have SMP hardware on arm64? Or are we going to need to
again add smp_on_up support later on?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
