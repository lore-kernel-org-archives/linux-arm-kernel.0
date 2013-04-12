From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Apr 2013 19:13:32 +0100
Subject: [PATCH] ARM: KVM: fix unbalanced get_cpu() in access_dcsw
In-Reply-To: <1365786828-548-1-git-send-email-marc.zyngier@arm.com>
References: <1365786828-548-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130412181332.GB5075@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 06:13:48PM +0100, Marc Zyngier wrote:
> In the very unlikely event where a guest would be foolish enough to
> *read* from a write-only cache maintainance register, we end up
> with preemption disabled, due to a misplaced get_cpu().
> 
> Just move the "is_write" test outside of the critical section.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I found it second time around!

  Reported-by: Will Deacon <will.deacon@arm.com>

Will
