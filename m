From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Oct 2013 18:48:41 +0100
Subject: [PATCH] sched_clock: fix postinit no sched_clock function check
In-Reply-To: <524C5B10.20006@codeaurora.org>
References: <1380732928-13897-1-git-send-email-santosh.shilimkar@ti.com>
 <20131002170917.GB30298@mudshark.cambridge.arm.com>
 <524C5484.5000601@ti.com> <524C565C.8010709@codeaurora.org>
 <524C5786.2090008@ti.com> <524C5B10.20006@codeaurora.org>
Message-ID: <20131002174841.GH30298@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 06:42:40PM +0100, Stephen Boyd wrote:
> On 10/02/13 10:27, Santosh Shilimkar wrote:
> > Really... I have not created patch out of fun.
> > Its broken on my keystone machine at least where the sched_clock is
> > falling back on jiffy based sched_clock even in presence of arch_timer
> > sched_clock.
> 
> How is that possible? sched_clock_func is only assigned by
> arch/arm/kernel/arch_timer.c when the architected timer is detected and
> sched_clock() in kernel/time/sched_clock.c calls that function pointer
> unconditionally. The only way I see this happening is if the architected
> timer rate is zero.
  ^^^^^^^^^^^^^^^^^^

*cough* CNTFRQ *cough*

:)

Will
